Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA96E80C9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjDSSCC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 14:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSSB7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 14:01:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2BB4ECD
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 11:01:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id qf26so461476qvb.6
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681927313; x=1684519313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKsyfbv0GnrN62lC9AnQSc3n7HV4a0vAcxxKbT+Q1pg=;
        b=QyKkmqAbz5AZiiXn8NOugaV2gyohj0vMUl0+kH1QTJbPKBHm3lLwBRsFR5gx2mqc3f
         /g1pqoMkd+Nu/peTozBEAmKhv1w3kq44+S9jAyQqwd6CkDJ/R4tCsh7BJCCHwf6R3POd
         DZG27UKoHB3FOE/Bchbdry3TFWbqf/DndFhB0jxujfNqDnPwNjxJR0B5hPGyuOP8p7zO
         Zw+b3rKqxv8upH6rAP0ETtAKofYQj2XlgHL8fTtRvlVeSzin9Mj+ON+ytdz5qiiq3+gm
         X8FwVbDFYw5xIQmtgaU5QJBQ5+2pTTx7g2RlNgIAXDUZRyR5vjXE9Dv1AJcFuIq9YaXH
         w/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927313; x=1684519313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKsyfbv0GnrN62lC9AnQSc3n7HV4a0vAcxxKbT+Q1pg=;
        b=PAPZmYnEPHnqSF/Onyk/VCiQ3nIV3Izx9vD0yfAVSvkd9heUKzevFA85E0ONwuF7mk
         gKnKFVXeO2OlI6hcr88jR9ogGO23JCjcT24xeVgY/aP7CZxu0WCw2g5SLwMQh204RadY
         zYEW0bd6+/X3w8dJQGDiNv90xt7kDgCjyAEP17kVHQfso/7eqoC3bzB4i3BFBQuf8C1s
         Ph7IZTYpOQwuFjzU++scG6YiQDnOGxc2MFWAqWXBQpgaa13n80MDh2i/BdjkmTme9iHw
         6r7iCj/DfHmZUqMp3Hi8NZKQqZsk9M3yqIEXKKthm+BGLBhYarUmduLtM6DQWfIPDeQU
         8oYw==
X-Gm-Message-State: AAQBX9fiCFgWUkFszZlq0EoUVOm7wVLunBGN+I/sK5dDWX0sK0R2FTsL
        dmmNEyMr04hemtJhnx61LCGDlD6IcqDNjhWPO9g=
X-Google-Smtp-Source: AKy350azD1CYj4V/SEqqqEa0ZPHWB2fTXJ4oJhcesq58XEDS04GXSOld3K6q8GnZFofsc0n0PuSdvDDr9ghR8AM8svY=
X-Received: by 2002:a05:6214:2025:b0:5cc:75c7:8f19 with SMTP id
 5-20020a056214202500b005cc75c78f19mr33681574qvf.10.1681927313151; Wed, 19 Apr
 2023 11:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev> <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
 <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <29e1ed5a-091a-1560-19e5-05c3aefb764b@linux.dev> <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
 <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
 <PH0PR12MB5481BD928589FE9219B3582FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17efd2ea-d0f9-a95c-a593-b989d8a45434@linux.dev>
In-Reply-To: <17efd2ea-d0f9-a95c-a593-b989d8a45434@linux.dev>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Wed, 19 Apr 2023 12:01:41 -0600
Message-ID: <CADvaNzW=d03HS89H=XJDZvZUxW8HRUR4h83-voneS7egVrg1Ow@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Parav Pandit <parav@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> TCP without net ns notifier missed the net ns delete scenario results in =
a use after free bug, that should be fixed first as its critical.
>
> Sure. I also confronted this mentioned problem. If I remember correctly,
> a net ns callback can fix this problem.

I'm not sure if the bug fix will be this in depth, but I have a
related question.  What is the proper way for the kernel nvme
initiator code to know which netns context to use?  e.g. should we
take the pid of the process that opened /dev/nvme-fabrics and look it
up (presumaly this will be nvme-cli), and will this method give us
enough details for both tcp & rdma?

Mark


On Tue, Apr 18, 2023 at 10:19=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
>
> =E5=9C=A8 2023/4/19 8:43, Parav Pandit =E5=86=99=E9=81=93:
> >
> >> From: Mark Lehrer <lehrer@gmail.com>
> >> Sent: Friday, April 14, 2023 12:24 PM
> >
> >> I'm going to try making the nvme-fabrics set of modules use the networ=
k
> >> namespace properly with RoCEv2.  TCP seems to work properly already, s=
o this
> >> should be more of a "port" than real development.
> > TCP without net ns notifier missed the net ns delete scenario results i=
n a use after free bug, that should be fixed first as its critical.
>
> Sure. I also confronted this mentioned problem. If I remember correctly,
> a net ns callback can fix this problem.
>
> Zhu Yanjun
>
> >
> >> Are you (or anyone else) interested in working on this too?  I'm more =
familiar
> >> with the video frame buffer area of the kernel, so first I'm familiari=
zing myself
> >> with how nvme-fabrics works with TCP & netns.
> >>
> >> Thanks,
> >> Mark
