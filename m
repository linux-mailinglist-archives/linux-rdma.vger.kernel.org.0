Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60DDD08F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfJRUqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:46:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45415 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJRUqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 16:46:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so6544471qkb.12
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PfSKiH+PRh3wAH2gyyRJOzZGVuhIGI1nnsU3t7/W50=;
        b=QH3A5itFoO3FHEtw1ZgdCRi2ydq66uJBDsxwASlfbU1FwDDFDmHDCOT0YOWrj3G9vO
         psd2aKzE2RD8BuNJnbQe/gt+K/FBTT7X8cUq+5UI+jKAGIjS66xr4bZY/IlwvRGdTvVu
         BqXoWdLQiVhsAFNjTwhQaO6Bhp9SM0oR060ihi3OwgBuDdyfN5FCI0m0jsZOSE5pYnC1
         OrMkIfVGSx7RUU6oBpaJuyCqLNuKUAVcBOzTOWB7vmAgr7AhKrQyJnDd37VzL6Woe3Iy
         tCQM+PiiuK63gUVcopBcb+t4L1Oj8YWT0H4jX9HTsT13jACX1ncGrgLAVnGrn5cyy5/n
         UYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PfSKiH+PRh3wAH2gyyRJOzZGVuhIGI1nnsU3t7/W50=;
        b=ZyRG59nDVTcfrk1LaFvk7OApiZRnGLEA2R8wKAjlgmvpcJIYVjYXXFULatlU1lJvrs
         1ZWwf/wrwpVueMwuRdYexq+rZDj56TtlHbMVQ4VZ4hoTVTdTXKyNSU7gwwUewhvGOuqU
         ZitcEMlufmtW8w6ugEI9fvxJETGrtSHDDO/VTmkb3lbOzl3i2m7oPN5nWXfHMjZ1udOI
         D2f6fwokyhqw0vTJxkulyAZE0LfdmTdw6bBFBFtB9xYGXZI6Vu5emgUjLafBFjYVi0Ce
         w3jhMV3C5MwpJ1hRO/WyECnHHonfdz1FJYI/J+v5KUBGTM9nbM0OjUtAJKPbF8sHbbG6
         87og==
X-Gm-Message-State: APjAAAVak6H/Lk+lYJmz+GKxDiFN7ISlmcxiI2hxIn6EPK34UnHS5DEL
        XG392a1wIRidygWHj5T3kh2MCQ==
X-Google-Smtp-Source: APXvYqxryYu/+FNtyedECRyzc5Gf5jwZuKf46S2saRgfaHUJN6UlWkVlkW4x7YOxEpQ4J7WpiTEMQA==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr11045924qkk.482.1571431609331;
        Fri, 18 Oct 2019 13:46:49 -0700 (PDT)
Received: from ziepe.ca (ip-66-51-117-131.syban.net. [66.51.117.131])
        by smtp.gmail.com with ESMTPSA id r6sm117548qtp.75.2019.10.18.13.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 13:46:48 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iLZ95-0001bX-9V; Fri, 18 Oct 2019 17:46:47 -0300
Date:   Fri, 18 Oct 2019 17:46:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Don Dutile <ddutile@redhat.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Message-ID: <20191018204647.GA6087@ziepe.ca>
References: <20190930074252.20133-1-bharat@chelsio.com>
 <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 01:47:29PM -0400, Don Dutile wrote:

> Isn't there a better way to mark a driver deprecated?
> 
> This kind of removal makes long-term maintenance of such drivers
> painful in downstream distros, as API changes that are rippled from
> core through all the drivers, don't update these drivers, and when
> backporting such API changes to downstream distros, we have to +1
> removed drivers.

You still have cxg3 as an enabled & supported driver? In RH8? Why?
 
> It's much easier if upstream continues to update the drivers for
> such across-the-driver-patch-changes.  heck, add a separate patch
> that punches out a printk stating DEPRECATED (dropping a patch to
> backport is easy! :) ).

The whole point of doing this is to avoid this work!

Jason
