Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1625124918
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 15:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLROIh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 09:08:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41681 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLROIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 09:08:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so1616784qke.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8A1y7RtMkfdiLdIpaUgabPLnCGfHAS7Wr8+oTh0nW0=;
        b=E9p9kYIX6DrCXW0FClJh/81JaOkdLlWigpZ6E2AfrF7cPTs9egIIGOFNoXRfQsHQXW
         av699m8pOeGVE6zwL7c3ZgtMxnwtlTUtRkhwmXy5yWMWRcpbe0PYsYIlg7CCuJUcEq+e
         co6f7X+mGQ0rg79f7RbYGu/aPmuANUcT3jxPlY6qclQymbvYoWCTWfblMG8vbnd/5UFY
         SrmsiveBVj8WGrC6M5vwgB2OtjuUT1xayuzKJyCAHQKkekeZIoIdSnY0YnkEg5QgVp2/
         cJi6nRxO1XVVvrAxBYqwQvh8nNlOzByWP07daxkeJ70O3Q/QTpyxa6bMGZW1Y6gMDEdt
         +gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8A1y7RtMkfdiLdIpaUgabPLnCGfHAS7Wr8+oTh0nW0=;
        b=jFQMGhtVZMTFSwK5RDrUmYwRz5vNPXKLB4RN96KLVPvsn3+2P+iydabP+rdfRKqClJ
         cIH8N9p3D+xRjYdBX2n787b9oYujGyQSvI3ep+08EIsFZy8yxFr3saZAH3Wm0OToGQLN
         Dvee2d+PPR7y1JlZsVb993BzIS5hqcWQ71HiFkr3+tM6Ur3IWOhFhYfO9ljLYmmawcRl
         7FMuvxeZLznUNvO7muS+kWOP29qNJQ/VrEfqT6eZWbawqIyPnCck6lbRC9JtXjC1r+6L
         gNJfE6yWp3RHEHyJIEXlarsvh2peN1IJ0Ybh5tLBw36OZq1m53IeYdM6j3qG49+4Vb71
         FS3A==
X-Gm-Message-State: APjAAAXEyTkD+aRhjz80OX+A7bkdplf7L3UGCBcVM3tsrppBFqpBYbHr
        boxDSFBZhiE4CCIjBkOLqnZkcA==
X-Google-Smtp-Source: APXvYqxnYntc9FxUogJPnz6+06ONqm6VfobPsl4CtspSSUJ6YmE6aaDfZJWulRrK2Wp4bEs7q60dUA==
X-Received: by 2002:a37:e112:: with SMTP id c18mr2591308qkm.481.1576678116290;
        Wed, 18 Dec 2019 06:08:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g16sm675224qkk.61.2019.12.18.06.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 06:08:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iha0B-00088Y-8c; Wed, 18 Dec 2019 10:08:35 -0400
Date:   Wed, 18 Dec 2019 10:08:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
Message-ID: <20191218140835.GG17227@ziepe.ca>
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
 <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 15, 2019 at 10:20:00PM -0800, Selvin Xavier wrote:
> Provide an option to retrieve the driver gid context from ib_gid_attr
> structure. Introduce ib_gid_attr_info structure which include both
> gid_attr and the GID's HW context. Replace the attr and context
> members of ib_gid_table_entry with the new ib_gid_attr_info
> structure. Vendor drivers can refer to its own HW gid context
> using the container_of macro.

This seems really weird. Why are we adding a new struct instead of
adding context to the normal gid_attr, or adding some
'get_ib_attr_priv' call?

Jason
