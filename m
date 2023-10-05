Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40A7BA186
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjJEOqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbjJEOoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 10:44:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A99B6FB
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 07:21:51 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77421a47db6so64516085a.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Oct 2023 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696515710; x=1697120510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KLi5kEVp7wM1kR6SXKn4FnJQGq1aKEW0YrkYzX5AsPk=;
        b=oFgQTzjQdg7oSjp8ptSiQxoWOaiNy8yX2kEGKzwPJ7iC/eW/Xbsb9AVw/2ID5dBLmP
         ibW/dZy1wb1Sdvk+LiUjWFmjygA0J/HpNSdLKHrEdr8vg5C74+SDT6VXGcJHnu3y7kPA
         QiQp+AzzDjea1SEtEKR2ynwDNksRzEJbrP1QBiMnUJpBn+Pmp5XtnDpZlzEf7sc8hLmL
         zEEQBH2yFafry7INJQFgNOtM6DU+dIsDGxB8mYiyY4QVEcqq50r7C6fSUzRXTaSTHBD6
         g3tlZ9Y1jHNhtjjZxZxXa7OPKaAkarmKXvlMdwOiCJV4tZUCw673vYs6AyCEAXq2J18B
         CyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696515710; x=1697120510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLi5kEVp7wM1kR6SXKn4FnJQGq1aKEW0YrkYzX5AsPk=;
        b=BVOW2exfVkGosojhTvmV6gvg4Px8ekl4QX7s04umONQbvDVRmOzIhQ4fvLYVAA+7Lo
         8IMRygjQtuQMEr4L+3LcdV9Rt/g5l4VFJ0C+ejYuZvud99bDO03vWn+1jZ9oDa6TPTzA
         R3+7xAX91xaTlbMDll1DvdyXiqkSVbNqhKZtNyvmQaqNL//sAvxAPvDgBNaApXCQHHo3
         H722OMQd3dAqiVD5FazjUYDKR4WVjkYvrVV6Y3Qv8Bg8YSTs6gNZfXPdx2yhNY4rldIu
         GlTCL9LH+AINslTcTyWr1LnCJDyxG325no+2e2VEk/8Na7EqiDXQ+NkmPEfyZmvgEfR8
         JDLw==
X-Gm-Message-State: AOJu0YypDS0SVVp5Db9f5YTMVv3VhPTUI7RDCemDwzXeZYKely3BysLq
        KKgojJyZxebVm5ZCTOJ2WbUgkA==
X-Google-Smtp-Source: AGHT+IHo/gGWVUv0W/igUd1P3ug0bMk35uJFzqIuqgP4SHAU5rjIqqIh05NULoEnDccg7+tCD8rZrw==
X-Received: by 2002:a0c:a982:0:b0:65d:afc:3a52 with SMTP id a2-20020a0ca982000000b0065d0afc3a52mr4388602qvb.49.1696515710311;
        Thu, 05 Oct 2023 07:21:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x6-20020a0cda06000000b0065b1c26c89asm519760qvj.145.2023.10.05.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:21:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoPEa-0044Mc-Tb;
        Thu, 05 Oct 2023 11:21:48 -0300
Date:   Thu, 5 Oct 2023 11:21:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231005142148.GA970053@ziepe.ca>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 05, 2023 at 05:25:29PM +0800, Zhu Yanjun wrote:
> 在 2023/10/5 2:38, Jason Gunthorpe 写道:
> > On Wed, Oct 04, 2023 at 10:43:20AM -0700, Bart Van Assche wrote:
> > 
> > > Thank you for having reported this. I'm OK with integrating the
> > > above change in my patch. However, code changes must be
> > > motivated. Do you perhaps have an explanation of why WQ_HIGHPRI
> > > makes the issue disappear that you observed?
> > 
> > I think it is clear there are locking bugs in all this, so it is not
> > surprising that changing the scheduling behavior can make locking bugs
> > hide
> > 
> > Jason
> 
> With the flag WQ_HIGHPRI, an ordered workqueue with high priority is
> allocated. With this workqueue, to now, the test has run for several days.
> And the problem did not appear. So to my test environment, this problem
> seems fixed with the above commit.
> 
> I doubt, without the flag WQ_HIGHPRI, the workqueue is allocated with normal
> priority. The work item in this workqueue is more likely preempted than high
> priority work queue.

Which is why it shows there are locking problems in this code.

Jason
