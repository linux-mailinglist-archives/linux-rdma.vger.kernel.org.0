Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC58D78D9C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfG2ORs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 10:17:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33084 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbfG2ORs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jul 2019 10:17:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so55582673qtt.0
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2019 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLiwWYbL4gvk1R/sQJJNQJWhWdCK5YylxReMGCshnKc=;
        b=i6ByPVsJ6esqSlyb6a8DSzWZ8X0Opvm9jiaWmWP92cve/Qb1U8XbH254Udj+Ytb5h2
         pIDiwfRMNQgDt1Nsl/xCnhA5PsQECnNnsOwVtEjJX0T78XxUQRd3XrYUnJpEvrgw4b8M
         Y/ytiPRbZ3iEfDO74MEBhJajSljuuSX1m2doMTIedy3y35tcvoxHDYdZuHYHTOLkmBVp
         UeV33OuxDIzqcWSo+4b4tx9fPwgeAaEuzlEiuok6FXbRO2WRFx0czfjlalmYOOHVBhSd
         uQ/9Hh3Bty6rLTI2Qu7O7UK9uH5IZz9/N/6U2Yze+mpWx5RFeRVW77fmLMO2yKDxVtW3
         uDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLiwWYbL4gvk1R/sQJJNQJWhWdCK5YylxReMGCshnKc=;
        b=tEkSE5TVqVqSfdnNym5Thhvr+yMrUHHR8k8xPXHKlea3xKK5orE7FSGkpoeYmR7fIW
         DxU39LuRavkltluKq7CPIad2C5QZVcrjD54dPZUmPAi9u36F/sNLQJT414Pz/NQU/FHH
         Kt4tpvGR0VbjkKO8aT+EZR9P+JMfA6fqVVOkjbZxwBTij4ukYp1Ddll0XJ0HR9HcC22B
         MWQhrmRJRw5zJ7IVFrF3jpdryjoUR7hWMwkhsl7vVRYfERGFNzJtM7+doWcZw0O9JOUE
         ALLg0fMJq6+7UU8rqeRw+YVmvLqHOU6y/Q09kNmFidCURsa71+n/6hMYZGr45HuiM8QR
         nbKw==
X-Gm-Message-State: APjAAAVWzzvWWjgVB/cHfIT5b42OArhA86O9tDXmYwLbL4o3XSbG/U2R
        p7e2z6iGBROIdZS+wBrpebtFSmzp1/PuLg==
X-Google-Smtp-Source: APXvYqzpBWCkHXRnP/5OGjoq5xYUmM6tNkBT5rmheuaSCRRxWikbFDsKB1/vofH9DunqrQhBF4KwPg==
X-Received: by 2002:a0c:bd1f:: with SMTP id m31mr79984588qvg.54.1564409867268;
        Mon, 29 Jul 2019 07:17:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o71sm25647259qke.18.2019.07.29.07.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 07:17:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hs6TC-0007ET-BN; Mon, 29 Jul 2019 11:17:46 -0300
Date:   Mon, 29 Jul 2019 11:17:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Jankowski, Robert" <robert.jankowski@intel.com>
Cc:     "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
Subject: Re: RDMA does not work with kernel 4.20 or 5.1
Message-ID: <20190729141746.GE17990@ziepe.ca>
References: <05523083C296CF4BA19B0EC6154D20A776D78CFC@IRSMSX102.ger.corp.intel.com>
 <05523083C296CF4BA19B0EC6154D20A776D78D25@IRSMSX102.ger.corp.intel.com>
 <05523083C296CF4BA19B0EC6154D20A776D78E14@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05523083C296CF4BA19B0EC6154D20A776D78E14@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 29, 2019 at 01:32:33PM +0000, Jankowski, Robert wrote:
> Hi,
> 
> I have an issue with running RDMA server on kernel 4.20 or
> 5.1. Everything works on kernel 4.15 on the same host machine.  With
> libfabric members we found that there are low-level infiniband
> errors. Example ib_write_bw command returned:
> 
> $ /usr/bin/ib_write_bw -d mlx5_0
> ************************************
> * Waiting for client to connect... *
> ************************************
> Couldn't get device attributes
> Unable to create QP.
> Failed to create QP.
> Couldn't create IB resources
> 
> 
> Full thread you can read here: https://github.com/ofiwg/libfabric/issues/5149

Don't use MOFED userspace with an upstream kernel release.

Jason
