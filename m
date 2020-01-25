Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7719214976C
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 20:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAYTYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 14:24:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46418 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgAYTYM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 14:24:12 -0500
Received: by mail-yb1-f195.google.com with SMTP id p129so2811899ybc.13
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fE+BdfQJyOrYWATRSpdduqNM1YEkmmIyzs2cOGMrdI=;
        b=KGt57QuHMprERFdzhfVsJN1dJJARrtbNmLt4UG7dyVIcrOCxij7OZ/lgq1w7+nbfTL
         RnuwLTxSyMOGZLVqQplCfUlcoq/KkcLM4zo9a9e5GKbEO1e9J9rYzog9JsSQNzC0fZ8Z
         YUtcJ+SwnwgfGo3TODBwd9RJ7VT4VzPRutoawsWvjUk2MPGVlD32STm97HfZG5yiZnsR
         RsgK7HqxQjGIjvquXK1CQ8u12ZGpWKGoMKKYvB3HZJbZpgPAsGLkae4TdZIIn6b/TlJ/
         0IgJUItqCW9h0vx0tXf2GhCXWZk0uR/UufuV4RY3bBYNvLtEAjjrN9p3N8P+JtBUYolK
         bSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fE+BdfQJyOrYWATRSpdduqNM1YEkmmIyzs2cOGMrdI=;
        b=m8KXVycWWDyTe7Wwgo4JP4MfRMTBIf9kkOO8VN7zaEB9p5jxi8Jne6ezhy7I/BL+UE
         QufG/Xizlg/DdS3jjUbvbzqGC8DpeuonuQ+ndG0Jx3NK13c0TWh/hEhxmLt8ZNFl0Git
         grDid5kbyriYD8bsPhwD+9q1eu1m4wB4og0lThpbvSIWVRK9LtLvpv5CCjfXphA/68De
         jmonbd1rhICjO0RCi5JKp+HKTJ2cdCyPrkqaHAJII7G+/Etnbvod+91KAqd8OAkPHfx0
         8kQsIeRVgowObm34WQM9NvYHgg2MZiochceh/iWoqT9VMErkvhTrBW9E2IKXS4UlblHz
         yBjg==
X-Gm-Message-State: APjAAAVsPL+lAIkK8PkNJSPPswKxjKLcSBA6j25pEfQvVCQ0UsIZm9W6
        uLEQDx/on0Lfjru4LNuracr2KA==
X-Google-Smtp-Source: APXvYqxnSvxonT8l4EXGs7FwI8GJJrEaynq8hTbAECSFwLJHUrvWAay12x9ZnvKOACPvjgJ78zTlkQ==
X-Received: by 2002:a5b:f44:: with SMTP id y4mr7109048ybr.319.1579980251374;
        Sat, 25 Jan 2020 11:24:11 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id q16sm4081057ywa.110.2020.01.25.11.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 11:24:10 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivR2M-0004c3-DQ; Sat, 25 Jan 2020 15:24:06 -0400
Date:   Sat, 25 Jan 2020 15:24:06 -0400
From:   Jason <jgg@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 0/7] RDMA/cm: Remove open coded structure pack/unpack
Message-ID: <20200125192406.GA17698@jggl>
References: <20200116170037.30109-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116170037.30109-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 01:00:30PM -0400, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Instead of using a struct layout with a large number of open coded pack/unpack
> inlines use a consistent set of macros generating GENMASK's for accessing the
> members. The definitions follow the MAD layout tables in the IBA and are easier
> to correlate with the specification.
> 
> Further the macros consistently use cpu endian values which will allow later
> patches to remove alot of the __be stuff sprinkled randomly around.
> 
> The is a follow up to the series here:
> 
> https://lore.kernel.org/r/20191212093830.316934-1-leon@kernel.org
> 
> Jason Gunthorpe (6):
>   RDMA/cm: Add accessors for CM_REQ transport_type
>   RDMA/cm: Use IBA functions for simple get/set acessors
>   RDMA/cm: Use IBA functions for swapping get/set acessors
>   RDMA/cm: Use IBA functions for simple structure members
>   RDMA/cm: Use IBA functions for complex structure members
>   RDMA/cm: Remove CM message structs
> 
> Leon Romanovsky (1):
>   RDMA/cm: Add SET/GET implementations to hide IBA wire format

Applied to for-next

Jason
