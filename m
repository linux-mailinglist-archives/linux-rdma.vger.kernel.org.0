Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC7107967
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVUXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 15:23:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36656 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 15:23:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so7452599qko.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 12:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zh3B/C6OCMmmjoWmRVzk4lZwmE2+DpQfyvEPNl2Qze4=;
        b=iv73naYDT96H5XswBO8ApFks9pz2rTg18q99JDHxv7mzlQGNXgK5SD0O++4+eNcn/5
         imsdGlt8iOUzgbKQ9oQzJRAPnN+gPqmPrCslN3hAGZ2M+pJEGew7XDXr1Dbe0dIN1AbU
         UYUSLL3GDITcBsUZ+KFdGPcFNFGx8wokF6ptE5DXPyDbjUcUcFVrYGAq3OeKR2gEd9Y0
         TmoItZl4OqFqgFLyMbwrR3YCAZODkIN/jx4A4gWnmsN+LOxauWowkmxT0m0STGRK1mh+
         4TpMFhWboiY0PwnO4XsADsJ0oki4iD/qUl8G8SDUlrcNQmqRQLN86qspFjv5F2wYag35
         RnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zh3B/C6OCMmmjoWmRVzk4lZwmE2+DpQfyvEPNl2Qze4=;
        b=MhUGUi/B3+SNeOSlGs0QkxN+2PEspDkwgMXkn1HZadldC1dgkw2HyjAsLWOu1NnHcv
         xn8mwLAoOqQ5P8UWW6w02X8lAL0R/gi30/P5byVTOk2HI5vXHwn2Ywk8tAX73jwUrG+A
         4yMVJ+0KycE8awW5JQy3/zJAH6ZVDrWa9rYzJdJeZcTNM98SsiAp7uMgcHh1bGZBP9SV
         zURGL3fBuBoEaXibSwQEk87hlwdDJ2IsXcsQVVCldvw6fIR1Q9GDMGiIDi1AHxRGIlo2
         TAonHN6z99YHtMrAq44HF5GFZpcGNkM8kWzX18j2Zbq6ea+gqmcS8uKKI2BRRbuWB3u5
         hSIg==
X-Gm-Message-State: APjAAAVzLI8iO2wieA6tSsf2IflR7x79zxS9BoiG5PyGIy9c2M7k6695
        kbio9JdnIRy9IAMU9YB326zSiQ==
X-Google-Smtp-Source: APXvYqxP+mCmYu+BBduTXIFFfzc2Os+SlMw5tR1EzW5SQUwfy1F0TRNGUmun/1QlBZp98P3paiV/cw==
X-Received: by 2002:a05:620a:139a:: with SMTP id k26mr6205092qki.34.1574454193430;
        Fri, 22 Nov 2019 12:23:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s21sm4200587qtc.12.2019.11.22.12.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:23:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFSS-0000M9-IF; Fri, 22 Nov 2019 16:23:12 -0400
Date:   Fri, 22 Nov 2019 16:23:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V3 for-next 0/3] Broadcom's roce driver bug fixes
Message-ID: <20191122202312.GA1316@ziepe.ca>
References: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 01:22:20AM -0500, Devesh Sharma wrote:
> This submission for for-next branch contains 3 patches, first two
> patches are important urgent fixes for Gen P5 device. The first
> patch deals with device detection in device open. While second
> patch fixes hardware counters.
> 
> The third patch fixes few sparse warnings from main.c.
> 
> Devesh Sharma (2):
>   RDMA/bnxt_re: fix stat push into dma buffer on gen p5 devices
>   RDMA/bnxt_re: fix sparse warnings
> 
> Luke Starrett (1):
>   RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series

Applied to for-next, thanks

Jason
