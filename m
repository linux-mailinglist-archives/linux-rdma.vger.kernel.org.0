Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F717870C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 01:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCDAdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 19:33:05 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33552 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgCDAdF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 19:33:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id p62so5440850qkb.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRbga26KKt4GxB0REX9xqELCJZu3/nGpKZ9taqW3uuE=;
        b=o1XhDG4CLRS1QpCBaTd6MFdXVP2P0bZosxTncpGA0t6T3Vpk1DzjQ0ReWrc6mwGp0A
         o45NyGMO92UOsS2KVsHqSbQxk5LjPpOnXNKF+oSmbwWSN9R05XDkeFWiipuOZKaBaoRL
         GXn9YDKRlBaeGqVfaATsttEZyv6LhGtRraT0nEDsWhT25Yb+S6bOJ8r6gfVVQnDH0qdG
         lvcY+r3dZct2EiY0CR2zU7DeOfl1eycDdSdRrtbB8Gz1tIhciyfYqlAQ7DlyzG/kw+PL
         tU/JYlYcRhd1JW1IaG+MVc/U7xd+mpS/sSGSjiKsbgi++TLEt3gT0yKvpEvC6TcKCauI
         Egig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRbga26KKt4GxB0REX9xqELCJZu3/nGpKZ9taqW3uuE=;
        b=m5MWrbY92s+h+3ASsNkfuWgpLAK2KI2RPTur1zYc7aSNsVzogZkIdXJacHJW9DlYZx
         P7oaDKL6g6g6VmTeNeynlHq0wN+WA6i4jWJdB89v82YFc3q0tDXXxQNNIWohVn62iePE
         kW+SrXBZczFYJpOiEHCY8K7qyzFljDb9/lMIf9I9NtSKTjLYGuxZoEqWn+MpHNdUVJbM
         6VObBXjtExmSwSBoun6eWUEgGkCbHHyW0V5iM3fOgY8+iSBMAwQki+us38WBoCLwwJhd
         7mP1KxFEYwM8Gec2L9nmp64ySSQgmm2dibMAqvaDK0z2qGdrKYHBf47cwBYyQ+pxTkY5
         OfIw==
X-Gm-Message-State: ANhLgQ3s8chAet5wFuejADJfqzsxvU/vOTQW6kO1R/BHImLiXR53L/Rl
        N8eQ9DorkTFDwOI54fEthBiVoQ==
X-Google-Smtp-Source: ADFU+vttyqHEsC1g4p3gCx+UNgq7rSItKx35kOg3UpNk5WebKAv1n8jhydANGEnSIe/oskm/FagWzA==
X-Received: by 2002:a05:620a:1210:: with SMTP id u16mr604413qkj.493.1583281984135;
        Tue, 03 Mar 2020 16:33:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n19sm5400021qkk.88.2020.03.03.16.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 16:33:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9HyB-0004Bk-3J; Tue, 03 Mar 2020 20:33:03 -0400
Date:   Tue, 3 Mar 2020 20:33:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/2] Packet pacing DEVX API
Message-ID: <20200304003303.GA16047@ziepe.ca>
References: <20200219190518.200912-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219190518.200912-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 09:05:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This series from Yishai extends packet pacing to work over DEVX
> interface. In first patch, he refactors the mlx5_core internal
> logic. In second patch, the RDMA APIs are added.
> 
> Thanks
> 
> Yishai Hadas (2):
>   net/mlx5: Expose raw packet pacing APIs
>   IB/mlx5: Introduce UAPIs to manage packet pacing

It looks Ok, can you apply this to the shared branch?

Thanks,
Jason
