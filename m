Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164566C49B6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 12:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCVLyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCVLyi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 07:54:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5E33CFA
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 04:54:37 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n2so22236581qtp.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679486077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFCDthmO7SKNEDKLt5wGZhFaLsV+2FlfE8Wtp2RKYkE=;
        b=gVEOy11rchjbzrKbHlTdlemkyFgQim3lCRt6GJo3IjJhA9d3SqHBLZ1pCzm5BNIJrx
         UT6qb+ucimVHCdR9YzdIABrZrhh03zBvVp+3KCerlar2710hlkm5Vh4hakpRJQfMx53L
         xJaxcGQ0b+BNXjUaBkUXdNaAUge+H33Nncn8kxo21QPfS+9WdVSV21HzBAkSrX4lhI1D
         fC4gG8lAjNMg7fZ8wNXU7o8+jbTEcsuthnFZ01lephziCyG005baA0UgmV3vnWv/gyOq
         752JpU0PDviV4Wcj0t5bfOXQthcXDuQ7gTExqyC289ebxNsdsvIXDpWyMIJCgqSsDhEt
         Se3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679486077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFCDthmO7SKNEDKLt5wGZhFaLsV+2FlfE8Wtp2RKYkE=;
        b=Q28Sdfr6dKub/SAIT+TvdpdLo4slnjTWiZctFbnSr2OoRR3r3z06xnTTu3sNQ0IY6U
         /QrM0Kf42pvUA1vT9FcfiF/ztmX4/2qXODhPowMnmoVARiYZjuS+Vj+m4V6RFUjlrx4d
         F7SzM0nieDX2Z2blR11kill5SAEp1Qrl85hY2to46M5DBZP9ge42zCzb3wRDpPfwZyE7
         CAYD77KdTCL5QT3lWe42rjODv30p0Nk++0Wj0V7t0EkWaDzrzg8gwbgybsmoDLL+mtk8
         GEQsNoL5oOsE5hzCDsmGSuamWFngHCzHb9RK+u8Z6pf7Lq/bgUu+0Sfdg+kq6IDP712M
         lMjQ==
X-Gm-Message-State: AO0yUKWFHixjEN/ROuNbRhWiCp+rZJNboARtQgsh/olh8WWH/1xYTUMt
        +rGkc0psE47rHPq/ThbhYyrvnA==
X-Google-Smtp-Source: AK7set8xMv8GivHPNn5ZveLjBpbB+76SMqwWyjDEObWuzBiKDUmE04BGwfJUmW1y5FUVOT0yQdYPOg==
X-Received: by 2002:a05:622a:11d2:b0:3df:50ef:faff with SMTP id n18-20020a05622a11d200b003df50effaffmr5824681qtk.58.1679486076849;
        Wed, 22 Mar 2023 04:54:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b003e2e919bcf7sm4407716qto.78.2023.03.22.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:54:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pex35-000lxb-D0;
        Wed, 22 Mar 2023 08:54:35 -0300
Date:   Wed, 22 Mar 2023 08:54:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBrsexPDqDIej/2/@ziepe.ca>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal>
 <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 03:05:29PM +0800, Cheng Xu wrote:

> The current generation of erdma devices do not have this capability due to
> implementation complexity. Without this HW capability, isolating the MMIO
> space in software doesn't prevent the attack, because the malicious APPs
> can map mmio itself, not through verbs interface.

This doesn't meet the security model of Linux, verbs HW is expected to
protect one process from another process.

if this is the case we should consider restricting this HW to
CAP_SYS_RAW_IO only.

You should come with an explanation why this HW is safe enough to
avoid this.

Jason
