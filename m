Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3F6E9710
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Apr 2023 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDTO3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Apr 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDTO3S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Apr 2023 10:29:18 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539112D78
        for <linux-rdma@vger.kernel.org>; Thu, 20 Apr 2023 07:29:13 -0700 (PDT)
Message-ID: <ecc2fe69-9e39-fe9a-9605-2418835c2e77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682000950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7NjeuOrzXsyKXKq3bVHuxMShaNaz429aFeukD1YjvU=;
        b=Rozfqwj+zNgYyF4174o5S3m4FsESK9y58V6AMBfe+3lx8QNRdj/bIZwXuTxgDievbmOsAn
        6JEYpKq/WxkIzq4Ym2QcBa9iBxK63W7RTkhNO6iiqudvuIuR+0q0PY1U7aWYFsRXQ/CZXa
        RU5HhvWUJidSoiDt9XqgquEJX0eM9vY=
Date:   Thu, 20 Apr 2023 22:28:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
To:     Mark Lehrer <lehrer@gmail.com>
Cc:     Parav Pandit <parav@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
 <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <29e1ed5a-091a-1560-19e5-05c3aefb764b@linux.dev>
 <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
 <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
 <PH0PR12MB5481BD928589FE9219B3582FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17efd2ea-d0f9-a95c-a593-b989d8a45434@linux.dev>
 <CADvaNzW=d03HS89H=XJDZvZUxW8HRUR4h83-voneS7egVrg1Ow@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CADvaNzW=d03HS89H=XJDZvZUxW8HRUR4h83-voneS7egVrg1Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/20 2:01, Mark Lehrer 写道:
>> TCP without net ns notifier missed the net ns delete scenario results in a use after free bug, that should be fixed first as its critical.
>>
>> Sure. I also confronted this mentioned problem. If I remember correctly,
>> a net ns callback can fix this problem.
> I'm not sure if the bug fix will be this in depth, but I have a
> related question.  What is the proper way for the kernel nvme
> initiator code to know which netns context to use?  e.g. should we
> take the pid of the process that opened /dev/nvme-fabrics and look it
> up (presumaly this will be nvme-cli), and will this method give us
> enough details for both tcp & rdma?

Please check the netns callback functions. You will find all the answers 
to your questions.

Zhu Yanjun

>
> Mark
>
>
> On Tue, Apr 18, 2023 at 10:19 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2023/4/19 8:43, Parav Pandit 写道:
>>>> From: Mark Lehrer <lehrer@gmail.com>
>>>> Sent: Friday, April 14, 2023 12:24 PM
>>>> I'm going to try making the nvme-fabrics set of modules use the network
>>>> namespace properly with RoCEv2.  TCP seems to work properly already, so this
>>>> should be more of a "port" than real development.
>>> TCP without net ns notifier missed the net ns delete scenario results in a use after free bug, that should be fixed first as its critical.
>> Sure. I also confronted this mentioned problem. If I remember correctly,
>> a net ns callback can fix this problem.
>>
>> Zhu Yanjun
>>
>>>> Are you (or anyone else) interested in working on this too?  I'm more familiar
>>>> with the video frame buffer area of the kernel, so first I'm familiarizing myself
>>>> with how nvme-fabrics works with TCP & netns.
>>>>
>>>> Thanks,
>>>> Mark
