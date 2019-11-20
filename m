Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3369103086
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 01:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKTAIm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 19:08:42 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37658 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKTAIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 19:08:42 -0500
Received: by mail-qv1-f67.google.com with SMTP id s18so8994648qvr.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c87ZRnKfkFwb+Er5Nz+pUba1hzgIl8uANKfWQXKhD+E=;
        b=LC/n02Z1CrZwRGFSmBGeBRviEPvtZmLFw64zCE6Py0/spL5OmmjJpX9qSS+1BNRP8Y
         rBOnJ08/3J7IIqS2AmNzXh9ePuEIjDvGWgbpARXTadUZj7GSwd3Tfiz6U0aNYFlOD8yk
         oOKEttqnJ+ZIrvNTlKweQhhXPKM0Npi+CqImU6BEnf3Zy0oh2Xockiqo6nCsHsbFmn5q
         E/1XDcF+Asd0eJdyVIHphfyQf0Q1aWMiQPD9T8A6yZwSC2HZtGAVi44f0hIGf/8ui5ju
         5ykb4Fk/vDB80qjwizzbiFrALqXGvHsT282EdxTdaYrEP6IlyZ/6+tCHa7KBIFB3oCfE
         vJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c87ZRnKfkFwb+Er5Nz+pUba1hzgIl8uANKfWQXKhD+E=;
        b=ddI/ax95IwcDHT4MFFMZo31xiAhbnMdoERWlVc+B2btEHW8bZZqTeMnGwrhh6+/x5R
         /lRG0BAYqqEau8frL5t/uvsL/VA3xAftyU0iaU496L7HZj96Q0TDSG4660HaLtzxHV/I
         SjjZWv5E7WLoa2eod0UY7ZWvrxlkqo/Imu6k/lOhk82WXwjeesUI8SYzEBe6mh8lQ0Mm
         cW2NF/+3IFDupHHG8sm045g+/TSxyd/h1A+kexX/qPGaFKD7TpywsCQHt+a7LqX2wugz
         gK9WHq2hLqTV8jHWGOsd4fZmFN5g2wvfd3nJ3YFsLoE8QzmBRVrhnf9hK3fhZdwjDWak
         QojQ==
X-Gm-Message-State: APjAAAVcQWx+L20e6aAbxS70oCga9yBr4phkTEw3LXbvCxaJgGcFoNmv
        K3IubQVDB8//t0C5NFoTL2IOSw==
X-Google-Smtp-Source: APXvYqyHC6JpsyUgMnFH/vHr6GurwqIC7phi/jGWbasG+gvRWYCFc2oItzSzTNaOD726Ktw1Y+eW3Q==
X-Received: by 2002:a0c:dd01:: with SMTP id u1mr49357qvk.69.1574208521502;
        Tue, 19 Nov 2019 16:08:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s42sm13113000qtk.60.2019.11.19.16.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 16:08:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXDY0-0005ir-DI; Tue, 19 Nov 2019 20:08:40 -0400
Date:   Tue, 19 Nov 2019 20:08:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191120000840.GQ4991@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 03:55:35PM -0800, Rao Shoaib wrote:

> My intent is that we calculate and use the maximum buffer size using the
> maximum of, number of SGE's and inline data requested, not controlling the
> size of WQE buffer. If I was trying to limit WQE size I would agree with
> you. Defining MAX_WQE_SIZE based on MAX_SGE and recalculating MAX_SGE does
> not make sense to me. MAX_SGE and inline_data are independent variables and
> define the size of wqe size not the other wise around. I did make
> inline_dependent on MAX_SGE.

What you are trying to do is limit the size of the WQE to some maximum
and from there you can compute the upper limit on the SGE and the
inline data arrays, depending on how the WQE is being used.

If a limit must be had then the limit is the WQE size. It is also
reasonable to ask why rxe has a limit at all, or why the limit is so
small ie why can't it be 2k or something? But that is something else

Jason
