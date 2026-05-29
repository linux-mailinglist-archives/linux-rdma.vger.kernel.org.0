Return-Path: <linux-rdma+bounces-21484-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIEYBQU2GWrzswgAu9opvQ
	(envelope-from <linux-rdma+bounces-21484-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:45:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC765FE1A7
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 422F2305F77B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3F36AB44;
	Fri, 29 May 2026 06:45:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF3AA9E8;
	Fri, 29 May 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037117; cv=none; b=HUbcQIDOYi9MloPob01VPoQHCyM/+rH/e+/2/KhXeZdCcl9dNN/JarWuFRQlVhv6TmLcqDWBfot9yKSWsPZIu+XAPeZ21N0z39k4NhNXBr82HkddzsA8LpskG++f4N0KOaX0dD4X2+QnQO+Foqra3vIVZWmjZUOe6yhL7FJrsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037117; c=relaxed/simple;
	bh=zYCFzaBkMPoZ2N1/YFoGX8YYD2S5NZg/5F/5Sxk3o2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7HNVh9P5RcrMJRXgeWOSwAenpx2VMHyFDwyYqhvyM8cySD9icpzvIy8fjV7jWgIVdQtYnpkhNhUOtrvEB4WdDVguPQ46qoylFdX6CKioUVZdxP/RBdouc4WBsva6fyo4QpcT7CD/6fJCdkrHYeOZ2Nm+ztVMFdEW1dTCErZg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: edf7de285b2911f1aa26b74ffac11d73-20260529
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:82224aa1-7e3a-4e07-afca-6c3ff0d6ac48,IP:10,
	URL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:8,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-INFO: VERSION:1.3.12,REQID:82224aa1-7e3a-4e07-afca-6c3ff0d6ac48,IP:10,UR
	L:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:8,RULE:Release_Ham,ACTION:r
	elease,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:dc42407474079f1a65705b7e76c5c18d,BulkI
	D:260520182225RF6C1K7D,BulkQuantity:6,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FCD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: edf7de285b2911f1aa26b74ffac11d73-20260529
X-User: sangyao@kylinos.cn
Received: from sang-pc [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 937723382; Fri, 29 May 2026 14:45:06 +0800
Date: Fri, 29 May 2026 14:45:21 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev <netdev@vger.kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
Message-ID: <20260529064521.4i5pyilf32au4cnf@sang-pc>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
 <1780035629778309.247.seg@mailgw.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780035629778309.247.seg@mailgw.kylinos.cn>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21484-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,google.com,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyao@kylinos.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 6AC765FE1A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:47:59PM +0300, Tariq Toukan wrote:
> 
> 
> On 20/05/2026 13:21, Yao Sang wrote:
> > mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
> > with the CQE initialization pattern. When entries_per_copy >= entries,
> > the function copies array_size(entries, cqe_size) bytes from that buffer
> > to userspace.
> > 
> > That copy is actually bounded by PAGE_SIZE in the else branch because
> > entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
> > However, GCC 10 does not derive that constraint and falsely triggers
> > __bad_copy_from() in mlx4_init_user_cqes().
> > 
> > Cap the single copy_to_user() length to PAGE_SIZE to make that bound
> > explicit and avoid the GCC 10 false positive.
> > 
> > Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> > Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> > index e130e7259275..7b024a5e13c8 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> > @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
> >   			buf += PAGE_SIZE;
> >   		}
> >   	} else {
> > +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
> > +					 PAGE_SIZE);
> > +
> >   		err = copy_to_user((void __user *)buf, init_ents,
> > -				   array_size(entries, cqe_size)) ?
> > +				   copy_bytes) ?
> >   			-EFAULT : 0;
> >   	}
> 
> Thanks for your patch.
> 
> This is a compiler issue.
> Did you try fixing it there first?
Hi Tariq,

Thanks for the review.

Yes, I agree this is triggered by a GCC 10 limitation / false positive.

I have not tried to make a compiler-side fix the gating item here,
because GCC 10 is still within the documented compiler range for
building the kernel, so I think the kernel should still build cleanly
with it.

That said, I also agree that my v1 shape is not ideal. In particular,
the silent min_t(..., PAGE_SIZE) clamp is too implicit.

I think Paolo's suggested direction is a better shape here, i.e. keep
array_size(), but make the bound explicit with a runtime guard instead
of silently clamping it, e.g.

        copy_bytes = array_size(entries, cqe_size);
        if (WARN_ON_ONCE(copy_bytes > PAGE_SIZE))
                return -EINVAL;

        err = copy_to_user((void __user *)buf, init_ents, copy_bytes) ?
                -EFAULT : 0;

That would keep the overflow-safe multiplication, avoid the silent
truncation in v1, and make the single-copy branch invariant explicit
for GCC 10.

Regarding David's suggestion of using a memset_user() loop, I've also
looked into it, but couldn't locate either of those APIs in the kernel
after check.Please let me know if you have any additional information
or suggestions.

If this approach looks good to you, I'll send out the full v2 patch shortly.

Thanks,
Yao 

