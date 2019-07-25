Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376A4756A2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfGYSND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:13:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46126 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSNC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 14:13:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so49951699qtn.13
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tN3XRP+DlXS9QDAuAkwb5juyA+0nYQNT6TiExQ2ZRCU=;
        b=XzOvIsMdT3tZcUim28JteCRCEuAU1MJ8QLF/XpcsjzuBmOwAvvjNsStbvdwIkXDLQJ
         xlzR9dvl5fWK1J5Mn0bCRIpMr+Q4U5JCn61bzFaEjbdD+1MA+EPNDYnoZcPRc9NEksQq
         Xp+Um+NSu/fNFFx25oUzma324J6KJMOr2FjWs0C2WEf6lmbdAMzaLepbXkmyhCiuaJ13
         ljsTzcgjVYOTFBjXmVw237IJYdG5fSMj/rStCHOCmuWXpweXutglVs4//jEjdy9+ZuqX
         ELOyhJxSlNjfSHK3GQYnoETRMnX1q0/HUi5JZ2gIodtAphkoTax+RRR+BN8bPBkzoBJ1
         oqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tN3XRP+DlXS9QDAuAkwb5juyA+0nYQNT6TiExQ2ZRCU=;
        b=TgdsWDYAPRyXgIRatWgP0KULbwgcYqIL3ZWmkOd5X9dGCSfNd/QwfK2nuRyLCmACEw
         tf34KlLmIEK/nggmZ6s0pBKS6OlCk2wlrDSq6+bITmOgzNOsZHY0Wo7timX5g8rrpRCv
         TB462+5JhYaOHBpIRSgeps5kV7RD0TMqAcWG9i+412zlN6L7Fy5+rBnSgHaCXshwDq4c
         Z77Og2kzdlUWPuYejNff8PNkL32XEMklE8SFsLe6SNcYd75deZKCIsrzhFneRca614WB
         ez2hrDO1+Ha9EhqjtTQPJgozbjcBScT2UkjTys3lzUGJ2X8xRZEiU7w+kqzepUTQInaY
         4OjA==
X-Gm-Message-State: APjAAAWHRHgquzj51XDJDAg1t2ualR1wv3+emcuo272I+ZQDNTwzp/xK
        ltXNJgjp4WlmmtLidXR026byn7b0QXBGYA==
X-Google-Smtp-Source: APXvYqz75ZfxnqmOiAfyjIXN2JiDBT4qtP9ueOn17kGQvDtpelTM6zCgUXvxIGysUGLQIp5XuKahDg==
X-Received: by 2002:ac8:22ad:: with SMTP id f42mr62953520qta.271.1564078381599;
        Thu, 25 Jul 2019 11:13:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z1sm23089957qke.122.2019.07.25.11.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 11:13:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqiEe-0000Jn-QS; Thu, 25 Jul 2019 15:13:00 -0300
Date:   Thu, 25 Jul 2019 15:13:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: verbs_match_ent device field uninitialised with new driver id
 matching
Message-ID: <20190725181300.GA7467@ziepe.ca>
References: <20190725173610.GA26368@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725173610.GA26368@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 11:06:11PM +0530, Potnuri Bharat Teja wrote:
> Hi Jason,
> 0c3cecfe04d (verbs: Use CHARDEV info from netlink to bind drivers)
> With above commit, `device and vendor` fields of verbs_match_entry are left 
> unintialised as match_driver_id succeeds always. This has broken user space 
> cxgb4 iwarp as it uses `device` to get the chipversion. I am sending a patch 
> to fix it in cxgb4 But I wanted to know if device and vendor fields being 0 
> is as expected. 

Yes, only PCI matches use these fields, all other match types have
them as zero.

Jason
