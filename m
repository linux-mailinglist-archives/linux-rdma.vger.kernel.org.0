Return-Path: <linux-rdma+bounces-15560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6CFD20693
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 18:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE293059EAA
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9693A7829;
	Wed, 14 Jan 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iSvYwuMa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36D3A6406
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409954; cv=none; b=EL6Xv2/xpnPXxGsWL7dq6IpJkYdYjIPu3sKEQoW+wTwBere2xHOs3ob8dr/HLzxGk4d/vBknaZTwOdMmwV+NaqSV/yEFU08uem7GZWO8sgAzft8WVH9/4atnkV81MPskQd0xQ0c+HrnpnGdVEjZyd749cKJWdDQKuhOOo7NHGcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409954; c=relaxed/simple;
	bh=NcJQBFcsL1vVARF3vlZxLnvJht3oFbeWwiWqZNWxXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfjHDgO3LzD2MI6A7ep87uoP/nP1joJtWDV4hNiLKFtjyS/0FiaYHzCb3AH+4US7gflKTtUwQ1p0VC8MH0cQMqLMlvQadFhzr/Pjd+PAV/JNs/ZB6jqRHv9NS7C9g9tabtaIvKsXZEEkww2qMVOleXGm6OG+pgs0QXRNlr4zuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iSvYwuMa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c52e25e636so2804485a.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768409951; x=1769014751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FQiABqhhqr0n1pLjlMak0kUK6JkqjwN6GBeE0TqWA=;
        b=iSvYwuMazgdUhVjumI0KP/fAZvEAJRvF8gW/qCJ2HytWjqZIPJ/L0RAs21ajWRQI8B
         RvtA+IRRuOpX7A7ZlUyru/uJzYwEaku2YsLzZyqPLSmemjKBf8rPJhyKbBVTlL4zZfma
         F2Qh+3Qb1enDVZkcl4z92JZ4Rab1LWX0jNbNbdTIGKJXS1Z3f2FXC6nENRZv5qP6eG9R
         fPSZVZujO1V5ubQUT7y3trb575n+9DKXOFZhsb3xxSi/vSxkY5j2tYzYaIjOxI4g8+uO
         Rao6IXslR3dKRutB08DoHDlZOoNaqmdFBuWqOOwkLVUHsjnwUaHnJpTVQb0vBwXN2FDA
         Gx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409951; x=1769014751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+FQiABqhhqr0n1pLjlMak0kUK6JkqjwN6GBeE0TqWA=;
        b=I1WtnA7KvncLnvfrvMH8diVFvxdFmy0oH7oKfPhh/d+SMXjSkDcpRB232IEziftq0s
         YqCmnBbnPag4wiE9LQFbTd30W+V1cq6RZFSsUJaaDOXHcW6lrit4UAUlwqGqeP59Qmw/
         CbC1fwGkCxylMhEMftbcDnhse8FdbFNMR3oNIKtRv1akUXAjAbE1S53eP+mA/3vlvm+0
         jDA9dwrKNd+GzPeav+7m6Nf3qH5dojAEIyZJaHEMRMdMjeNtqz/AzlZPfQNoF34UhYj0
         qs8j9lQe4bkTsyTfyHvZW/h7OSTYQ6Oi24awAqWAYccHY/f9P9Am28nC8vcIHp87N8TA
         uBNg==
X-Forwarded-Encrypted: i=1; AJvYcCWM6q6SbDPCtO0gloi2Xf7YhYPq7/IedLMbvgL9XuPBUr9xW4Em1OFOIFKBwx1t5Mvjql1rIWmav39p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IpsiHfFawIwv54mBZHmOQJuTFtxUeWZZ5ouLW1LRVNk5jo3Z
	xf4zJhne/GAmVWjGA1d2G7NIi23Njuh0MfLvamWOC6Le1nbvVN3EkZHrsYWwQqJby4c=
X-Gm-Gg: AY/fxX4T2GKtI5L819rTpynDcqr4qtNQm8P+krxedV4dL+7cjAEvXmgQACWsVj3eRAI
	NJMXQGvl6KgN4M8jiP1cXqJfPpY9doWJAUZqEAaTWJgtJ3U2xeckKrMFIucodLh1/bjQSGIO/Lo
	3blc/ZT+o3yc5dh6sJ7/2oHVE/FivUZKJRAxjoeNgLwhstITO8gfpKKmJQyHpdAIzIlPbNJA6+u
	ArTcIUsOm0gv/ntziQLzawtyKEmR6bxY/wojKSs6FUQpDVHGcdryI7jrHDxGyZ8oloxSpCiwj49
	ZbwlZLKguQGyFUKyoYsQ2s4OiQjtU/8/ihHVmCJJ4g0LLKxF45Z1L75a6wsqxyAQe48xLipK59l
	J+pnGS0zv0PF3k4NxiTp1QETDKP0kMK/Y4IenwegK7qIp89bfkf9vdW7ESIb+JoQexdpq/YwNxU
	amr+kbGRvnjcOhFbOEtOyTm2KLCI758cyDH189xiF4Bb9tJ+MYRDWxlh5W6Y83mSJo3GQ=
X-Received: by 2002:a05:620a:288e:b0:8b2:dd0a:8807 with SMTP id af79cd13be357-8c52fbddf67mr439586485a.80.1768409950642;
        Wed, 14 Jan 2026 08:59:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530be76d1sm199389285a.48.2026.01.14.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:59:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vg4D7-00000004FbL-29mx;
	Wed, 14 Jan 2026 12:59:09 -0400
Date: Wed, 14 Jan 2026 12:59:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260114165909.GA961572@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca>
 <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca>
 <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>

On Wed, Jan 14, 2026 at 03:06:26PM +0530, Sriharsha Basavapatna wrote:
> Thanks for the pointer, I looked at uverbs_cmd.c:
> ...
>                        scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
>                                                 cmd->send_cq_handle, attrs);
> ...
> 
> I can pass the dbr_handle (idr) from the library, in the driver's
> request structure (bnxt_re_qp_req *req) and then try to lookup the dbr
> object using the steps below.
> For example:
> attrp = rdma_udata_to_uverbs_attr_bundle(udata);
> uobj = uobj_get_read(BNXT_RE_OBJECT_DBR, req->dbr_handle, attrp);

Please don't pass object handles in structs, the attributes must be
used to pass these things. The driver can obtain the pointer with a
simple 

			send_cq = uverbs_attr_get_obj(attrs,
					UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE);

Type of thing.

Then QP uses the uscnt to lock the CQ:

void ib_qp_usecnt_inc(struct ib_qp *qp)
{
	if (qp->send_cq)
		atomic_inc(&qp->send_cq->usecnt);

And then CQ checks it during it's user destroy function:

int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
{
	if (atomic_read(&cq->usecnt))
		return -EBUSY;


This way the cq remains undestroyable by userspace while the QP is
using it.

I think you should have the same pattern for these doorbells.

Jason

