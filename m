Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DC6C4C62
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 14:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCVNvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCVNur (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 09:50:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BFEFF14
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 06:50:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r16so22587099qtx.9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679493023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bcMdqrDTpV7GQZYoqohGEjM2vNgmi5vHWqlOFfnZpI=;
        b=dfhl2VGKLqCwhC0ttLb8Wuc1TfP3XEfsEx4DS4tWjMKzEdsef0/40Iw20bzsxUTGoB
         Uc377nAaWbzkSFLwcS75f56Xgay32nTjcFyNoN86htj7htsF9hh22OWb8pqnBbaN3416
         Y5vrMmVM+mlmzrFnbocrqzxmixjmIJZHdMAk+Fbji1YrkYBoy35TWvLW+I1Vn3yz2b7L
         dP2lS1YHH7q1KvOdKYQPst09wXNV9sshjO3o04g/MY7+KJYQ3OrsW6A++P7luorGWvOc
         6atugU3tCj3swuVpwOo6hIec1r2DFWLuxmsr/lKgP0NYpc4RzxqdVogq9C+1Ik2/wtu2
         iWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bcMdqrDTpV7GQZYoqohGEjM2vNgmi5vHWqlOFfnZpI=;
        b=E1VauOiSp2T/mzX+ZAM50ujXC4bd7qLKwic82MgB2zcyO2gukQ2IK3TjS4lJmHKVaH
         LsdNg/z+ZVU/PbQfgcW6QAubKZMYmS86CXgPhVLiZxsvAno8P6LL/knuxPxD9jDnjMbY
         qxQ9EA5M2pbIXeQANw1yoXOvsud9CtY5uBdfCXkum4u8GCTmoV0LjITH2x0XjZRrAOX4
         rAdkpm7blwkHAzcyLucYTdfiF4gpua26fydL7OK6rHk4uuETwdrTi2O4oHhloZ/Rq4UN
         Pjq8lsnMJWHpml9pXuhTjWmUauZlba8IZRBv7BnRZ64zkBxX6xW5N3o7T9jBuAXb24K3
         I2Yw==
X-Gm-Message-State: AO0yUKVPBbzb9gL8aBGavlAHTif8KpFKTmsCPSi19WVwENQHg40XLgRR
        lmo6cGYDAk3pWVeBibpdfBfbPA==
X-Google-Smtp-Source: AK7set9HaqgA+mB5FLvP7fffXukwDbftHJGzBXepOVRzCPehSGRFi7DTK75viPzlJj+TGqowV41iBg==
X-Received: by 2002:a05:622a:1744:b0:3b8:6788:bf25 with SMTP id l4-20020a05622a174400b003b86788bf25mr6466186qtk.23.1679493023634;
        Wed, 22 Mar 2023 06:50:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d140-20020a376892000000b007467a4d8691sm7488138qkc.47.2023.03.22.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:50:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1peyr8-000nYT-Gw;
        Wed, 22 Mar 2023 10:50:22 -0300
Date:   Wed, 22 Mar 2023 10:50:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBsHnq6FlpO0p10A@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> 
> > > No rdma device exposes its irq vectors affinity today. So the only
> > > mapping that we have left, is the default blk_mq_map_queues, which
> > > we fallback to anyways. Also fixup the only consumer of this helper
> > > (nvme-rdma).
> > 
> > This was the only caller of ib_get_vector_affinity() so please delete
> > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> 
> Yep, no problem.
> 
> Given that nvme-rdma was the only consumer, do you prefer this goes from
> the nvme tree?

Sure, it is probably fine

Jason
