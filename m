Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E285E1638A4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgBSAmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:42:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34665 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgBSAmv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:42:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so21506233qkm.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7feH/MD/Y2bTl5vnxPPwWYe9eB5ajm78K0yFYBLD038=;
        b=H0np86IGzsPUIRcFlYdYtxJzuMc2DOaaR6WWWxbjIDGmzxQgF2TPCwuvF/NSS9MX7B
         vkHxgXE86G5r2ovZFUHzsTU/UB4fVfa/jJpQJCwhTWxCEOMrJGCQcupVKxDUIs5+05Fw
         GHH72/9kWy4kTARtoxSfbDGQYMa2yydDAvKpE9ljgiIxri8lnDVoZ4Ejtck+2fuyo/RF
         JB2Tn/nJuMZqlC393G48493M9CiPGMLINzp4xb/0edAuUxKZkgpsBrm7guKhXJDXvEDT
         yebm1VKnri5WFzD1X2tzAtJMWPoz6Ll/nrKMDY1729WKHRBvPOeANEyPXq90qCCENAri
         hSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7feH/MD/Y2bTl5vnxPPwWYe9eB5ajm78K0yFYBLD038=;
        b=p8rQObfdvoA1s43k8UZsktLUCT6AgM2EWY1J+LAUO0iazYG6EXdNc6GlwQSV9oX901
         mTdpQEFuYFXEqKOsY/V/5fRnZGsntGuHBsyrZf8ZN0KuQ3h6B6i5tSJkpqqEO/o/kKru
         OVDKWCCvWXi1ShZQUu4MGSON2OlKEVLeXaTCVR6vO+u2KvT9jsgtKTd2V6SpkgOzynRj
         SLXOaOqski2nLOpa+B2eam5wEWS1e9Z9SYFOGsTZ2737UBqRy51CzOXAZszapfurBEjp
         s1KTPOrGVFEO9PrsAL014idIGoJX490NGDriUXK6Cg1qHJsaF8y6NSw1WlOC5EhtX/su
         2Yxw==
X-Gm-Message-State: APjAAAU9F8qyiD0jr/UlKLnxetRsZZkU53soQYm+RFNWot4xTckYewFb
        VRAmO1oSpni8o3UwRIubhnuxmw==
X-Google-Smtp-Source: APXvYqxNixxDKL01vty1i1aTE0NZaAwCtsHwXPy+IdQ4ysv/lHGwMv5LXsHwHydtt5KUCSedq6yfiw==
X-Received: by 2002:a37:494f:: with SMTP id w76mr21752058qka.309.1582072970477;
        Tue, 18 Feb 2020 16:42:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z5sm121661qta.7.2020.02.18.16.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:42:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4DRx-0006Jw-DK; Tue, 18 Feb 2020 20:42:49 -0400
Date:   Tue, 18 Feb 2020 20:42:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 13/16] IB/{hfi1, ipoib, rdma}: Broadcast ping
 sent packets which exceeded mtu size
Message-ID: <20200219004249.GA24178@ziepe.ca>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 08:19:44AM -0500, Dennis Dalessandro wrote:
> From: Gary Leshner <Gary.S.Leshner@intel.com>
> 
> When in connected mode ipoib sent broadcast pings which exceeded the mtu
> size for broadcast addresses.
>
> Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
> mcast mtu size.
> 
> The RDMA netdev uses this value to determine if the skb length is too long
> for the mtu specified and if it is, drops the packet and logs an error
> about the errant packet.

I'm confused by this comment, connected mode is not able to use
rdma_netdev, for various technical reason, I thought?

Is this somehow running a rdma_netdev concurrently with connected
mode? How?

Jason
