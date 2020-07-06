Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7F215458
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGFJGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgGFJGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:06:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB59C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:06:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so38414599wmj.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GUHbS3PRHbxYaNos1kkckw4SmHdFJeC7zEBUpQCMBm0=;
        b=hmnNXquI4jxlbKXXYUfgseChGvMb+QKmNhYPuiy7lFLdXKfAoXMMHy+2F68GaVKBNG
         oRFOLO4B0UXCI9Py0gCcfeGa8nFaaNTzkKxkuH4PDsPErXNxel0j0nLocduhtEKIGleX
         vzUv82h3LZtun1wG6hwoOnanuzcxjvq0RZhZb77/LCWm7lYd/5ZcPovumgY/woW+u7Mn
         caQL0WRcOhxV81j2tR60DgyrS1dCNjc6X7mc9Gz7WaJiNEinTFiyoU99WZJpU8C6ZP0X
         5J4tmw4MPy1fYgJbQao8crNiHpmm8zpv0FwoLSj8sYY81spNmi2afSBg8pAgJNKtPrC/
         QR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUHbS3PRHbxYaNos1kkckw4SmHdFJeC7zEBUpQCMBm0=;
        b=rZablXNwRwuTThP7nwvAHaYJJWSmyfBIm78QrJ+SuZcXsE11v/GKoF5BwSAvuxKeYu
         8ABrcXYeNlMJbyZQ26zhtpvWsHCbbLJ53YiYnjvOyZn7Qt13FlBL0MU0SpqgHtawj/EF
         4O8y70azj5EtaH6jD1kluv6gLNoooQK4W1RCdRNbjnQxq0CkS46ozWTAV37ukU0JXtCx
         TfHBmUoVStWWTIdLwj9snWmnMULpccPMgy8n/QoKY5a7JVo++ezsJYRc+y5Qg1T5X5t1
         tOLEo947oEE5ITjGTiPaaakibG/UYFopeljxO5NRsPSoApr4X3STG6EDFF+37Oy2t8Wu
         YOrQ==
X-Gm-Message-State: AOAM530n5nR6iyZR1fFafZCPoD6xvGY1hYDSQV2oQCBBB9oTEvFGf9Hi
        DFK/5CEatEP3e84YVo8my1pdqEIEz3k=
X-Google-Smtp-Source: ABdhPJw4O5NeV1gCxdAQpN05ZPP+1uZTN/rGBmKEGMZFlHWLd5cuXH7oG0wHcAu8W2FcRjnCaEnERQ==
X-Received: by 2002:a1c:a181:: with SMTP id k123mr48769551wme.172.1594026373808;
        Mon, 06 Jul 2020 02:06:13 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id h14sm24247652wrt.36.2020.07.06.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:06:13 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:06:10 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 0/5] RDMA/providers: Set max_pkey attribute
Message-ID: <20200706090610.GA366031@kheib-workstation>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706075419.361484-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 10:54:14AM +0300, Kamal Heib wrote:
> This patch set makes sure to set the max_pkeys attribute to the providers
> that aren't setting it or not setting it correctly.
> 
> Kamal Heib (5):
>   RDMA/siw: Set max_pkeys attribute
>   RDMA/efa: Set max_pkeys attribute
>   RDMA/cxgb4: Set max_pkeys attribute
>   RDMA/i40iw: Set max_pkeys attribute
>   RDMA/usnic: Fix reported max_pkeys attribute
> 
>  drivers/infiniband/hw/cxgb4/provider.c       | 1 +
>  drivers/infiniband/hw/efa/efa_verbs.c        | 1 +
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 1 +
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c        | 1 +
>  5 files changed, 5 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.4
> 

Self-nack series, I'll send a v2 with the efa patch dropped and target
for-rc branch.

Nacked-by: Kamal Heib <kamalheib1@gmail.com> 
