Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA76313CC3B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAOSiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 13:38:16 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33735 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSiP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 13:38:15 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so7851782qvn.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=94AoO9gngPlTqs8X93b0tH5qojpHg98VGpX5yk3Hbio=;
        b=bw6OkYtaCWXznQJosrly9SoPPe1MVkGOS7oiLQ2h6/vd4DYYZfdQAPB7gYEhvtRc1U
         cmb32sg3urLTbeV05Dwdv/kyEZjzbukSiC4HA1D4Dv55JUw9TExxLlCby+6XFCaAY85l
         bMXavTFUJhCKoMvlQ80l48hNpiwLdpsQ6CXI7V6dIm4B6N963CS2dd0LMZ/Mn3gVCZ4R
         Irzf6td7t2kuDCAchJpE8hti/nGEes449NzCIc8sa9F/onYorxypRYmuYBrxxwzCIQBR
         FpG8K/AzFYjFXDenjerSu5ewp8YWJ3Z/fHfxt4nX798aQJefRTVU2nwUe7fpkzCiLPyg
         sbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=94AoO9gngPlTqs8X93b0tH5qojpHg98VGpX5yk3Hbio=;
        b=KwLmTH0o2OkjEWUpE5vINgkayOINW1JFFhIRZBNYRv1rMUljT1IKqzaEVEdqazeaO3
         YKSA3AMqtfV/UCxg+q6TQAyWZ1DeAQ1cd1gefMRG5fJ3ehEtIAosvNvWlJ3SEhVtnkHh
         SjdPEA7cA1oGvJGskBvvOXWa+5vZTRF10Q0OibSwGnVWOsUBNI1fIS+3APgcosIMENhS
         qu6I6ba0Klnzry0LpGwm7xrXWmd1OlFRSIZR5l65mwpkkBULH671uEWDYpd0om7rmwCe
         L7BmdXYgwsxFqgh5emjoZm5LWwuF9CnStsM4BVZWiETZLe67yDMg3YtpEksD7FbKs09Y
         RV8A==
X-Gm-Message-State: APjAAAXYp6iES3xyhgZT8QWFUuuHjroARmhfPf18ubF6sjZwTNckyX3d
        kk/D+AlcypFYFRFBaBIk8jmddQ==
X-Google-Smtp-Source: APXvYqwp2IOdW9tpXDFO957Q4PEC239SP0ZN2lIl6AiHYqMb1MymeqbUvuVzk2fIYUhD6i7bTFDmmQ==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr26511714qvh.24.1579113494834;
        Wed, 15 Jan 2020 10:38:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q73sm8750204qka.56.2020.01.15.10.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 10:38:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irnYT-0000If-Vz; Wed, 15 Jan 2020 14:38:13 -0400
Date:   Wed, 15 Jan 2020 14:38:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Get pf capabilities from firmware
Message-ID: <20200115183813.GA1114@ziepe.ca>
References: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 11, 2020 at 06:32:38PM +0800, Weihang Li wrote:
> This series add new interfaces to get capablities from firmware of
> different types of hardware. If it fails, all capabilities will be set
> with a default value. In addition, we remove some redundant fields in
> struct hns_roce_caps.
> 
> Lijun Ou (2):
>   RDMA/hns: Add interfaces to get pf capabilities from firmware
>   RDMA/hns: Get pf capabilities from firmware
> 
> Weihang Li (1):
>   RDMA/hns: Remove some redundant variables related to capbilities

Applied to for-next, thanks

Jason
