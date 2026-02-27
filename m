Return-Path: <linux-rdma+bounces-17296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KImzCWCxoWmMvgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:59:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE31B9599
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793AD30A3CDC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98690429825;
	Fri, 27 Feb 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bddOLB6w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522C426D15
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204138; cv=none; b=V01v1T01y5Gd1b8iJx60L9cnGl8mF4/0op/FAsZahFclyOeylkn4/AdKNNkYxOk9QTZi7SKvZCBOTP0j7k4j4w1BHCXWpdYo1ZwL5vffqM0hgCo0wWTGLB1DAyuWE7hvLKILqkGPT8xaUh2NUQsLo4B6vtK/0Zezmtkd29gkvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204138; c=relaxed/simple;
	bh=hiz00qRo+gJPIyqDDN8X4PSaiW0SmJY5V53PRQYG2fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7t6ITNe0UFGg8bNjTpn8LXZOtcMGc8anWYewRmpWp6cOV9rgqHwA8v9InZn8Lrh019bHmsQ50oUy68XENEGduBE2OVCrlrJ+x7gB2ZEEZg09EXVx43NOV2x5dl380mtsKETJttTkXzX5W3f8C8xpjG70WKBFzlZr4wM3huhjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bddOLB6w; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb5138df1aso215210785a.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772204136; x=1772808936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiz00qRo+gJPIyqDDN8X4PSaiW0SmJY5V53PRQYG2fk=;
        b=bddOLB6wkQaWPkJgSS8OVql4r2GQjgyhxFJXCAb8gWam2lewjWDeIdtbcEQWFv3GgB
         2GdflMo8YFOApBbs8h4o7bWRQcRDq66BH1Q1hAstkOJ1ZHxVqhtjmcIKU8p3aIH+ssfM
         2hbkiLrFZ70/NrCj0oMFJD4jAiJbFTxNAiAmqAFr48EFTG7ozhyRO286xT5+8xT2Iq7w
         Q4ziVJlv8tdxcclcAEZ/xBETdT8LbIIWBwh/iNRPg9xSH7XQu8mnE2j8QXuFmrJUawi0
         zIqbjJoGTlwi4gGPb8jhR500khIykUXWrX5bSDAS4H+DV4y6vn6W6WTLKx+Ii9qBSq80
         RJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204136; x=1772808936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiz00qRo+gJPIyqDDN8X4PSaiW0SmJY5V53PRQYG2fk=;
        b=DW965jw7xMceWiQHVQVJZOadyCiFkJSN298dYeMPDMZcBVUHYuVFhQ4HGX/RHi74uQ
         qFiYIru13TJ4BY9bJgLxcwP2UQRvRrtKM5IJZ3DiTLktgQ/Ondbz5fx7nQU7UBP/4IYu
         9jLNuCi++gfmOQGmntwzRHFabYpxJ85aQJDxT5QvJHkEWrpfluUFVIwYHgoL76XJdwDw
         OdvdL5Fm4qLCsHMT0vK06xX12iDDFRt2wXDd1ZVwkeWWTvwacleS7DKyY0ygDXfNN5h1
         QjKjRROhJNl8MOf00QFCa4ChrxP910bMI7McLbXx6Wh8hlAViqYk0V8z5G60YHQCXJPt
         h57w==
X-Forwarded-Encrypted: i=1; AJvYcCWwE8RvcEpIrYa+rcaq6Z2TePbulgj3BLYPVq2xCQNDT7GQ7cOHJQZtwDGH6qJyMwjPagx5dPTrrvyB@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiBypFocGEypxxkYMMwwBnbKmWn3+IusnwgfsGCLNfS0N0Pqw
	AHE91wwDK+8EZ18UNAz6Q5IUf8S5xdqgEnSjxKHY+yDCSg/g5qQqYldeS6eXLp0YolI=
X-Gm-Gg: ATEYQzxhkF1jT7+g83z/Tg0mWNPou9atgYHN/vgFnvwTLM/pY7GC1KV3YrlnwIwTAGG
	OCCrdnYvzfCGmU92hIN0dsu8b/KCgxpwJMoVLVyHuUQYzs9+X2YD/HoYqc1KT8v63RiimUjEMpw
	2eCE5Bljj8R2xtdMpa+WUGDM4e3fDykol5C9LX90rGlxoEOCH6oXmb2tYd7D7q7kx6D6U93AP8L
	tEDyFB/XDH7S20j7Csrf9ARiZ+bnEgVom+qqg6/x7aRqkL+gR3QKEgfKTSIl2FP7YP8dV8q2JTo
	bPbJsXCMXpIqYcjB5Deq7Gb/hbcoPFcPmI6moX7Y2Q2Wo+eIX5kgeo9l+pW3xrkkr6jLboDflmf
	Q4HJ6GWOGo582CY8k0a8rjsMtcxpFhl4csLETUfydEuXrRf4rZ3HhkxJ10z9aMHAtD6T26H+24j
	jlxn9k/TYRdiT4/ZA6aauyp25PSHYbMK6OXfDNUHZOaKvoU5/0ZsEOxhoWDpNDDKSPs9mgPkt37
	QRXuXc+kTh7NQzChLw=
X-Received: by 2002:a05:620a:2892:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cbc8df1e6amr380289985a.45.1772204136082;
        Fri, 27 Feb 2026 06:55:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf71a8cesm491603885a.38.2026.02.27.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:55:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvzFe-000000016PX-3Q45;
	Fri, 27 Feb 2026 10:55:34 -0400
Date: Fri, 27 Feb 2026 10:55:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
	"Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENIXVtyZG1hLW5leHQ=?= =?utf-8?Q?=5D?= RDMA/erdma: Use
 NUMA-aware allocation for MTT tables
Message-ID: <20260227145534.GL44359@ziepe.ca>
References: <20260225085143.1721-1-lirongqing@baidu.com>
 <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
 <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
 <b00bcf9a1aee447eb64d955c52851c05@baidu.com>
 <39e148d1-6a56-863f-8126-e92d452b3106@linux.alibaba.com>
 <20260226070954.GC12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226070954.GC12611@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17296-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96DE31B9599
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:09:54AM +0200, Leon Romanovsky wrote:
> So why do we need this patch? The xxx_node() functions are useful when you
> need to force allocation on a specific NUMA node. In most cases, a plain
> kmalloc() will allocate memory on the same node as 'struct erdma_dev *dev',
> which typically matches the PCI device's NUMA node.

I think a naked kmalloc allocates memory on the numa node of the
thread that calls it, which is not the dev's node.

IMHO it is best practice to allocate DMA'able memory from the NUMA
node of the struct device.

Jason

