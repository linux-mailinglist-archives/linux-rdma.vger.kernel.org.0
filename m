Return-Path: <linux-rdma+bounces-15171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2629CD815D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2554301175D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D91F3B85;
	Tue, 23 Dec 2025 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gZw3AknG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E41624C6
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466209; cv=none; b=jJMYRotQU0mAjR+wXA8rLkjz3dGwWf5FCzbJskFUWdyRlZ36k8lq2BFkY/3g37NEaiX5k3tDbkRIaQ6kGtGGqRU0YaJWWIfEhEWVU0o/uRRyHVIxzNxB50A3aHs/raNf2y1JmLd/1wxRLEu3pg/e83/vJLCfXayAD5KnKkJ+2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466209; c=relaxed/simple;
	bh=GyNqOUZ+1X3rQzHh4YKcDfcDdv1i6qU7wqsqlLMhd0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMsTX2V3ABIDLyfZsHuc7KVjIzhysUbegAEeeMtN08KBCJ5K/IPmr+lHjLCrBbE1RRzNIGcvBbUs2/HrJqudNhU8HyGFzukLTbyiixBLPRJtNCstY4aez0Rr09PIoOeLSUbM3PF27qZc+lYrpgTljs9C6TdVp8/K2x9FsDvxNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gZw3AknG; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id XqCpvMpeaVCBNXuYLvFEKy; Tue, 23 Dec 2025 05:03:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XuYKvE1p7vXvHXuYLvIdEX; Tue, 23 Dec 2025 05:03:21 +0000
X-Authority-Analysis: v=2.4 cv=e4IGSbp/ c=1 sm=1 tr=0 ts=694a2299
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=NvFtkyhO6lhFgDomvqQA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rkJ8Ikj3ciqsIopG15EtfvppotpuY6yhyIiQS++7BiQ=; b=gZw3AknGAphvGgdK57FPejwD/G
	L4BtUpodikl4SuKCFIB+iJJNKf5NeE6m7sJ1LOZHkJSDB0vUI42r7l0MU7l6JFbkX0WNjzEWxGTGL
	pDcVi4RGqn7vrwno3LOcHWls/0X9lZ52JeO3DMiOVCB7vmti4UMYBmqsYBOoXQ4sJhFqS1cU0Lxiq
	UBLiOt8spbd8Rm5rSS8OdYxVnhjAsDuXAD+/zMLlVMorGQg/dyduVULdGJn1rQ0nzpchcubFcsmPK
	2z8azvM4ibrY8qR1CvcC7LKbpyfY/V3ov8h8fr4RMcteCpUyZELyMJeUZt+bGTIs9cNYXK4i0SKlL
	qPxmhALQ==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:62629 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXuYJ-00000003T7R-3byC;
	Mon, 22 Dec 2025 23:03:20 -0600
Message-ID: <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
Date: Tue, 23 Dec 2025 14:03:06 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251223044129.6232-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vXuYJ-00000003T7R-3byC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:62629
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPgDwNZyo07N8Do6Crwi1aBWj4k5pCSlf/6gkJvX8nBqMx/wPmhN5vQqI+IwvjvWjOumw/u7wmJx8thhpluvGQvc2SVHc9cZj9D2iCD9AkIkIDKB1VY9
 pxur9oZ6xan7h90RQMyWfZ0C5lw+YE0KBn1HCnSxJF21oWCAvMnmPfzQaByAXdRiL0U7SCtuKg/2P8a4+0R6Pvgqb7F2ibo6PN/DQlL/m7ccAvHPns+yNWv/



On 12/23/25 13:41, Zhu Yanjun wrote:
> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> 
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM) and a
> set of MEMBERS that would otherwise follow it.
> 
> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> start of MEMBER aligned.
> 
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after the related structure --no
> blank line in between.
> 
> Lastly, move the conflicting declaration struct rxe_resp_info resp;
> to the end of the corresponding structure.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> V2->V3: Replace struct ib_sge with struct rxe_sge

What are you doing?

You're making a mess of this whole thing. Please, don't make changes
to my patches on your own.

-Gustavo

> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..3ffd7be8e7b1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>   	u32			rkey;
>   	u32			length;
>   
> -	/* SRQ only */
> -	struct {
> -		struct rxe_recv_wqe	wqe;
> -		struct ib_sge		sge[RXE_MAX_SGE];
> -	} srq_wqe;
> -
>   	/* Responder resources. It's a circular list where the oldest
>   	 * resource is dropped first.
>   	 */
> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>   	unsigned int		res_head;
>   	unsigned int		res_tail;
>   	struct resp_res		*res;
> +
> +	/* SRQ only */
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> +		struct rxe_sge		sge[RXE_MAX_SGE];
> +	) srq_wqe;
>   };
> +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) ==
> +	      offsetof(struct rxe_resp_info, srq_wqe.sge));
>   
>   struct rxe_qp {
>   	struct ib_qp		ibqp;
> @@ -269,7 +271,6 @@ struct rxe_qp {
>   
>   	struct rxe_req_info	req;
>   	struct rxe_comp_info	comp;
> -	struct rxe_resp_info	resp;
>   
>   	atomic_t		ssn;
>   	atomic_t		skb_out;
> @@ -289,6 +290,9 @@ struct rxe_qp {
>   	spinlock_t		state_lock; /* guard requester and completer */
>   
>   	struct execute_work	cleanup_work;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	struct rxe_resp_info	resp;
>   };
>   
>   enum {


