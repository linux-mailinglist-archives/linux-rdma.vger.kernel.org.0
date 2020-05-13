Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86F1D1D05
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbgEMSI1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 14:08:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB564C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:08:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h26so578151qtu.8
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJCmiNr4Ox06ipFQXB+ITbJ9L/CvdANFXox6qgREMw8=;
        b=oeufyIS5xHOyCXUxVKnbHo03WoTk4lgdiu8OKjhF5DiHPN0i4frlKNx3Ue9WAzNd9c
         pkuyCZMSNZj/S0iWHIKKgga83aAzokB+PANAGDBji8hJXht2RitT+eLF4twW7giif8Er
         NzDlDv9LqjTPLr/YlJauvVlHPy/Xyfnd4TniwZCC0KjqWAv5g57s2966TBofXQG9iKa7
         0UZRxV9kBhK0Hhv2HroDhtGA1c1cE3LkQYBaiG/c0sDvGt56SC79TDRvtFlTpwgsvmiM
         dZ7k4AQ4sEMcKj6OLMqQGStfTHooOQvwVDtSN6sSrLH7wOxbpBpZq7OHa6Q78SI1BOJM
         y6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJCmiNr4Ox06ipFQXB+ITbJ9L/CvdANFXox6qgREMw8=;
        b=qiHAofWaj5L21euAEv71rhbBJ8B8yhVIPF7+GDeZax8W/H8a3HgSBwmBYia62m6l8y
         GZWytQBS+SMiNqU7GoctcfGLRN4LvLdv4o0CJDKGO4EIHMau5MIqKxixh61ULoDA8rOE
         2q3HpyAQmYJ2mGtHeP8OUTl7++dSmf6L8U6EpsfdmGVoEzDXm5x4q9BstIkrWlCEgjCd
         8x9XY/YH/LpOYBVcSjCheNt1aIon7suKkslVsnJn30p2tr85Uf0aqKfTnfmq1jc8spYK
         UTLS4/lRlkupXRNXu2PfUp6xViKvtprnJwcnQ3duwE+dl3xE53njcm+MG90oJYZWQTQ1
         2n3w==
X-Gm-Message-State: AOAM532QIH6FeCaLGhCRzB9hfK5UZzF5VCWpRre7GmGjyGnWjYhoxRWv
        beEMiCFSRTSth8cmGN9njzpcmg==
X-Google-Smtp-Source: ABdhPJzkPyNVSO4aL1HEsk1DkuH0xo7G5mW6TTa8zBFHJpWzb4vOYLvCyC1t9DHFVvUCbiUse5B7qg==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr370670qtt.252.1589393304863;
        Wed, 13 May 2020 11:08:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s30sm348150qtd.34.2020.05.13.11.08.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 11:08:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYvnr-00079k-IU; Wed, 13 May 2020 15:08:23 -0300
Date:   Wed, 13 May 2020 15:08:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513180823.GF29989@ziepe.ca>
References: <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation>
 <20200513105045.GX4814@unreal>
 <20200513111435.GA121070@kheib-workstation>
 <20200513113118.GY4814@unreal>
 <20200513123837.GA123854@kheib-workstation>
 <20200513124334.GA29989@ziepe.ca>
 <d3e729d7-97c0-607c-b1b3-80a2df47cbae@acm.org>
 <20200513180244.GE29989@ziepe.ca>
 <e205763f-b36f-484e-3b16-8363fc438242@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e205763f-b36f-484e-3b16-8363fc438242@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 11:07:10AM -0700, Bart Van Assche wrote:
> On 2020-05-13 11:02, Jason Gunthorpe wrote:
> > On Wed, May 13, 2020 at 08:25:41AM -0700, Bart Van Assche wrote:
> >> In other words, on my setup the ib_srpt driver was working find with SR-IOV.
> > 
> > But it won't be properly discoverable without the
> > IB_PORT_DEVICE_MGMT_SUP flag being set on the physical port?
> 
> That matches my understanding. Even if srp_daemon can't discover an SRP
> target, it is still possible to log in by writing the proper login
> parameters into /sys/class/infiniband_srp/*/add_target.

It is probably worth revising the warning message to reflect the
actual harm

Jason
