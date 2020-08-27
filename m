Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE125456B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgH0MyK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgH0Mx0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:53:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D5C06121B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:53:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so5719129qkn.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcbWJ5ffnyZwEAA+mcCOuKnBu3qTUAk0lR0GBNk49hQ=;
        b=hopSa1ZspH18qM7vJ1eJ5OJzwwxz1yuxJ5sdbfQTCjW7LSMDpTpFwm/JiREGnBc5Lm
         +Xk9i3GMeaf9h3BFVeK/aiclh10i9cAgcm9lvGKLQx3PrRoYea9F1reIx1LtOxRoUXVb
         pDWwjic0E3Oi9CLx2Tq8k8LUELeCoEY588wCM0wTtI9tpovdz/KIoR6PktNew6/bdArY
         WRkSBBaqnbLSOiNcSn4uJZ3UMacQV12CY6GEBHvadGJHo55PjZ6sd6utaV0Wfr3SCvMr
         DAfmqmddiMJ8xnQSWmm1YsJXSarHhqzzfWJP5naFTYAq5z1TQ3ZGS2GKCrwZUq/L+WpD
         CFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcbWJ5ffnyZwEAA+mcCOuKnBu3qTUAk0lR0GBNk49hQ=;
        b=DGsCtvgVc9rVEMfb/fFnW/Io/gPTx9B0uJjlp60obsCvPF+iVccTT5LVM/2c5+9mL8
         5S/IumVKGen/IjTiqgC/14caw9h0JyQGZiEWBgecipsXQrqUVE/qwHTOHrwlZunRc5wR
         noQVB8r8X8zD+Ns0jYvLFqwYkHXFzPF1M9XOq9NyPkHEvckXKAOrfwHS9L6mCjo6BTxX
         AlDvYJjlebtHnubVlraoPeWOyrSlZ3ISnyXHS8ahbFcTSxDspruOgfLK22W99cSJWG5f
         tKt3hpI4HI/r2DLwiIgDP65Ok9WCx1x9uT3Fp/JR1TyYNxcp23lKpOd5QNveAlaeZW6r
         2m0A==
X-Gm-Message-State: AOAM531/sybykutEKsltDdmmbKw1uGadDRjHpWiSVYg7A2s3JNOkJ8eC
        nyIXk17NIGqnBCuSZgJN5L/OPw==
X-Google-Smtp-Source: ABdhPJzcYj5ulnua9LP3pXrS/B4Fp8wbTTue5E24UqFl7pUryTGaCt5Il0essIEg3fX0mKD2RAwOew==
X-Received: by 2002:a37:a04b:: with SMTP id j72mr224234qke.352.1598532784399;
        Thu, 27 Aug 2020 05:53:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b206sm1656083qkc.11.2020.08.27.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:53:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHOo-00GtAE-Tq; Thu, 27 Aug 2020 09:53:02 -0300
Date:   Thu, 27 Aug 2020 09:53:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 03/17] ib_user_verbs.h: Added ib_uverbs_wc_opcode
Message-ID: <20200827125302.GN24045@ziepe.ca>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-4-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-4-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:24PM -0500, Bob Pearson wrote:
> This enum plays the same role as ib_uverbs_wr_opcode documenting
> the opcodes in the user space API. It plays a role for software
> drivers like rxe.

It should be done like the WR then:

include/rdma/ib_verbs.h:        IB_WR_LOCAL_INV = IB_UVERBS_WR_LOCAL_INV,

One copy of the value only

Jason
