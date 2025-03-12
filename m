Return-Path: <linux-rdma+bounces-8601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12108A5DA7F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D451888AA2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDF23E324;
	Wed, 12 Mar 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIt+VKhV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EF1DF735;
	Wed, 12 Mar 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775655; cv=none; b=Cw7MUsCGBEtvaAI50t7W7vmkvoasBjNt10t84yQBCWute7RO/k7VOhkM0nuBTh/vTcY89Tjib0X4nEpQFakNs5EeCvvc33+8gJ4CIICQfUGTXVqAsPQlh3nnJntPLdfhSDZHimLVWIN9Li4I4KWpGoYBAYiCSW1Z4/wkzqoZ08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775655; c=relaxed/simple;
	bh=JWuqx9ev09zMCgB43NM3mJXWzgwwNwCrolV+la2DxIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etFHaZFHNEML5jebHi4vX/Qxx2YNU0Tvxu9MOZ3aurLwK1ehQywa8FM9tdbn+8EXYX9m4K2tVqPEVj2kSr8Yhahtc5TyVksFV+cHH0QEKbb2ZY8gsk/Mp5aGh8mbt/EYoa88jujw17eyQEpnAb2Fxjf8/4AY09HyENbqkH15lnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIt+VKhV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223959039f4so130318805ad.3;
        Wed, 12 Mar 2025 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775653; x=1742380453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JAqpNybORepsGV2E//3k14JpOrJ0zrUql1ugOGN353k=;
        b=TIt+VKhVy2r2gguYAA5MLNWbBAhCGKAu+jalU/mc9LsO4/660fI9ofuv3lw3iVGUfh
         rWQjllubwBLMsKGE+mJ4x/9CJStr8HaTouzOGmm0SSKz/ZSSQWENuaLbZYYZuM0XnIgX
         /tbx2WRBYBZ5KaqOUrMq9EaKlO4CCcF5LaaPQcIKI8P/B9aji2iSD2CzqyAZL8LSOhga
         vCGVSbUZKDVdyGDJiSFIKYuA4RV7laOyVBxoqVPqrFng0/h3EiFEgz/2QL+mi9YS9GhH
         8tmopoRqaR9TESjHmPZVp/dEwB1Xuryt5Lwwp+186ugz5uCnvRiVWSjEldkhPxwOAkiR
         whLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775653; x=1742380453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAqpNybORepsGV2E//3k14JpOrJ0zrUql1ugOGN353k=;
        b=quNdjqzd5+jej8mnpyJq4Yc2Wvh8Q6/8dJ5EC8frsxmTEjsCtfCE7DXEegfWvGD3jT
         XrS5aesdd3ZiXHkFrqetr/sDqLqevvjt793RGOsl2vviSmJm3wi7lzjWyWPwOtO8GFGI
         c7CqIpoToxY9pGGxXaknXybYtSrOQz3c56ocVrjibD1c1yT1zfGGfRg/8eO6iorC615r
         p/TDTQdPqtVlWduLreQyZ2ZKfG2VpzNgTC3eSd/AYBNK79fJsj5ORw7srwIIBcEslMyb
         1o6EIvrSIaburfjLo9146CoCKUb7GGhlYeMOmDrhsH0mxQIOihNkLzzcSU5NokL2KpdB
         gSiw==
X-Forwarded-Encrypted: i=1; AJvYcCUTNsIXo6h31grij+plonpW91CbJe6qRxOoOh9hocPtH2ut3WtnNakGsvivIM3sRFaNRDXX874Z@vger.kernel.org, AJvYcCWUUV0zmED5LEYhyuyyAuuuiUznaYoaFpBViEmTkEaM0dewNKTSd4K00OTECXGZXLPnRXjjE5nDcMIeMw==@vger.kernel.org, AJvYcCXj+md6u675LDhlOftlUdY74ZLWbjiXURv5IRY8Yc9I6ObrIai+it8b2QIr+iwiAidl1R3UsbGVjQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAUMZt/J8ltQEsC9QCa8hSdD4mTU76tHWul/gbJNfTs6U0i5+
	O65TFOzxCqLkEYuNDNKTo2j0tQU5HgrvrxTGnOlf4rB2DoFjzYQ=
X-Gm-Gg: ASbGncucEdASovsXOaEQuX5PTlPQ3zYPDao6V5HVIzoyR7Zo4uU50o3cj0Wi1GoE1U8
	wsS1SMpepDeDCc59kexlYhbKMVPujXLOsSM+4E+hQT4CwweSIShS3IjoJSAb9OElILUZ/RGpSDX
	WLVONcP7PHrvu53phBD7RVNDCops3AC7NVfY2akR8+I1QnOh4bxoc5k70W1oFpJT9UGHXYVFC4O
	EpJxGhW3ziWMoTqVWZu165a95iccNfBSdGNmyp+E7v1BSw/7kqgV60rlZb8z0S7+OYxRSd0wYC/
	zKtfbgWehQ5QP6sODNrV1vJ8V39bL8JDuus884lmW5Lw
X-Google-Smtp-Source: AGHT+IElKLAxUVE+TL78ng9X/ZK1bRtG0Gsflu/ybImAKXGjmr+DEeCiOpXeMjpBBqP9r8z/OL6LdQ==
X-Received: by 2002:a17:903:283:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-2242888d06amr274426335ad.18.1741775653473;
        Wed, 12 Mar 2025 03:34:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736c14cc7b9sm8363641b3a.140.2025.03.12.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:34:13 -0700 (PDT)
Date: Wed, 12 Mar 2025 03:34:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <Z9FjJAgdmWcepxkg@mini-arch>
References: <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
 <20250311135921.GF7027@unreal>
 <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>

On 03/12, David Ahern wrote:
> On 3/11/25 2:59 PM, Leon Romanovsky wrote:
> > On Tue, Mar 11, 2025 at 12:23:19PM +0100, David Ahern wrote:
> >> On 3/6/25 12:21 AM, Jason Gunthorpe wrote:
> >>> On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:
> >>>
> >>>> How do you imagine this driver/core structure should look like? Who
> >>>> will be the top dir maintainer?
> >>>
> >>> I would set something like this up more like DRM. Every driver
> >>> maintainer gets commit rights, some rules about no uAPIs, or at least
> >>> other acks before merging uAPI. Use the tree for staging shared
> >>> branches.
> >>
> >> why no uapi? Core driver can have knowledge of h/w resources across all
> >> use cases. For example, our core driver supports a generid netlink based
> >> dump (no set operations; get and dump only so maybe that should be the
> >> restriction?) of all objects regardless of how created -- netdev, ib,
> >> etc. -- and with much more detail.
> > 
> > Because, we want to make sure that UAPI will be aligned with relevant
> > subsystems without any way to bypass them.
> > 
> > Thanks
> 
> I hope there will be an open mind on get / dump style introspection apis
> here. Devices can work support and work within limited subsystem APIs
> and also allow the dumping of full essential and relevant contexts for a
> device.

[..]

> More specifically, I do not see netdev APIs ever recognizing RDMA
> concepts like domains and memory regions. For us, everything is relative
> to a domain and a region - e.g., whether a queue is created for a netdev
> device or an IB QP both use the same common internal APIs.  I would
> prefer not to use fwctl for something so basic.

What specifically do you mean here by 'memory regions'? Netdev does
recognize (as of recently, devmem) the concept of memory regions in
the form of dmabufs.

