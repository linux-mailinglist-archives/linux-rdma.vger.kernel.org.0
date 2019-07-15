Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96369A3D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfGORyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 13:54:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42892 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfGORyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jul 2019 13:54:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so12309000qkm.9
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2019 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W1xb8n5nmOPslV6OR7t9SQOx/zL3y+hrKkYX7jathJM=;
        b=CVk4QzcdsGGSSrsdv3DGrUTocaa8QV+YSlErb8yCkWkIHzdAmJFrST0RIN7tVkDav2
         rz4cHTwhEyljiC7Aq+Nacdz7WG8Z3SdRc/GgNKRFCys5DeIqOLC4LyDpXIE5L0gB22sh
         pDF3vy8v3OpYj6J/3R9LWZedzhDCEIHPu08t+GLpc6yfbEHsp4jH3uOuCnDAz1sOeF4S
         IrHV3Q+hxK7dKwB5Byift2Shivo3zXCMOzKP96yW2b++y0ikW0B0M7ipyH2X6s+U39xj
         SLrUvvlaaUHG40z12Keomm28JFDu5n9VW6i+dKExw/nTRyU2CBBnckMvYvWzLDfNJxK2
         eNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W1xb8n5nmOPslV6OR7t9SQOx/zL3y+hrKkYX7jathJM=;
        b=ffgnAPPJ4pBV2GiR6CoiWfDkvWPuFUJmDbNhZB3X7z5Co1sEI+NmvQScvsdrRVBrpV
         7NAjLtb6wtoFKuGVZk4fDE5iWVIcY4B/+1cBMvh93kOE9GIPIZBWbNcC++q027sKH0Xy
         zwEdzHm8zxLFW3xwWcHcvN6GfZmiR+cUx2GgLWIAXhsSl5MjpjcYRrT7LdhgHtmGYCj8
         x72FLifSq6zKYdVhWsaWY8Gdy9pZnqYnCQ5iuTHgoTGIPXKqloIetyPQxZ1pYfH7LCR5
         zUQGiYSflpApDYo8V3xLn4TndSq7x9swkFjqLqXlruX54McGmYYCYZwFEFc49gi3EXGZ
         vSkg==
X-Gm-Message-State: APjAAAVncVLr6Yg6V0ysBOk26xJT5aCRrKm168j5XwFNDsYB2/Ja9o44
        3T/z3f6KmVDNBU+6PYfesAeF/WpprVlkFA==
X-Google-Smtp-Source: APXvYqyy/xv6y/lrPARrW4L4Zn7ChwOIa8/5XOvavFOFpZOrTSy7N9jGkd0gQ6f/FbWAfiRUYDEUDg==
X-Received: by 2002:a37:3c9:: with SMTP id 192mr17687804qkd.37.1563213250633;
        Mon, 15 Jul 2019 10:54:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 5sm8719867qkr.68.2019.07.15.10.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 10:54:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hn5Av-0001mk-JK; Mon, 15 Jul 2019 14:54:09 -0300
Date:   Mon, 15 Jul 2019 14:54:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/6] More 5.3 patches
Message-ID: <20190715175409.GA4970@ziepe.ca>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 15, 2019 at 12:45:14PM -0400, Mike Marciniszyn wrote:
> The following series contains fixes and a cleanup.
> 
> I noticed that 5.3 rc1 hasn't happened yet? So I'm not quite sure of
> the destination here.

You shouldn't send patches during the merge window. If they don't
apply cleanly to rc1 they will need resend.

Jason
