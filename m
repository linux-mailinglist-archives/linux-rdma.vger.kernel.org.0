Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44915D9D3
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgBNOxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:53:39 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37104 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNOxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 09:53:38 -0500
Received: by mail-qv1-f66.google.com with SMTP id m5so4387758qvv.4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXX7qWQLw5iUl+Yr9TnbcnXXBJ8gV/9E4bU4j8wPzLg=;
        b=FZFovExwaWSG+83m3KJ6VNb/3Qpj/mH1DVy8GOmh6UGHrKw0FL4gDpBvP+GDR9M0eL
         3u974bKjaM6/dAfGSkEp1ZwypLuZOfE73IX+tcPH4umifFoaONXCNmZgVmYY8TYa8ytl
         CHKB2lh6/9xUq0K6WQfJH8LqbKG9H9KUey7l9BxpK+Z87byIxhH1gMpFoLFFanjefkqs
         Z2FANM+2yBa/nKGmphblSJIx/UM5153aSz6ufzASAGucstLK60SgiMtpaC8Ko/kbRX/r
         gBAGYRPbZMn/mbGcyBiavgpmHHwlAZ7XNsajvckAmBakuAr0LE2QkCh9Fy4rZ292slcp
         oNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXX7qWQLw5iUl+Yr9TnbcnXXBJ8gV/9E4bU4j8wPzLg=;
        b=OMWNzZsX3Li+J0vGFaYIXBhYhwarfgcaxWu9plomXmx3LX15JeFCeJZ7yBhQsikmCz
         LreqwRKXcJY1E22etzEYuxfRDsCNPMtQsSlYaUtiy420w6+VsqlMyXJ7QbCCWLlFOXxL
         CGL3DHMVVc2Gosw2BhHJKbSnWtqWHS5XRMRM6btUCsQGEkVulMKndG9qmUju1fkzYlMm
         nFWWhPRsxZXRiTLu+7lpRqCl23v5UhRmJW1zn0S9s8KNnYRZI8znqFujgV9hjVFSt87x
         TOXQ7H5dkfhQzMIDBIVjXMGfGrqYRXoTDSsvtuHZBmays2jNiCaSMr1Ut8fSJoYC7zZR
         mUJw==
X-Gm-Message-State: APjAAAWrfyjoOiciD0raySZyf/sB3OSEfyqrcCHK6xRkJnFvxCLtxXJ7
        IksdgK0m8wfh5sP43d2wTI6wMQ==
X-Google-Smtp-Source: APXvYqzkHrLUNBZ50yV41b3XpgpOdtqCYltwJdqPIBGC27H7eH4iq9iYvMpvaEWIWp/w/lQPp8lFKg==
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr2393334qvs.111.1581692016483;
        Fri, 14 Feb 2020 06:53:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t55sm3648523qte.24.2020.02.14.06.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:53:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2cLX-0007UE-1f; Fri, 14 Feb 2020 10:53:35 -0400
Date:   Fri, 14 Feb 2020 10:53:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [RFC PATCH v4 22/25] RDMA/irdma: Add dynamic tracing for CM
Message-ID: <20200214145335.GT31668@ziepe.ca>
References: <20200212191424.1715577-1-jeffrey.t.kirsher@intel.com>
 <20200212191424.1715577-23-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212191424.1715577-23-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 11:14:21AM -0800, Jeff Kirsher wrote:
> From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
> 
> Add dynamic tracing functionality to debug connection
> management issues.

We now have tracing in the core CM, why does a driver need additional
tracing?

Jason
