Return-Path: <linux-rdma+bounces-13095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB03B44558
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 20:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658585A7632
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A82D3759;
	Thu,  4 Sep 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="NjjbSXCA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99B3164D7;
	Thu,  4 Sep 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010434; cv=none; b=j0GXd6bP3z/6PE3t/G/+D7u8SWdvqzpK3rkVbg8QziJMe7OTZhuLilyqHwCpPaH0co5OTFfuKz2pebbCj7t9Ps+KbA93b+fCcnr6Y20Iv+ByvVtCfezkYIaueKqjs6JBBNtGeeKrP4A0VZl4AHiBvUpMFinXnBEYEhNOctqCRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010434; c=relaxed/simple;
	bh=lVQu9EhBxvprTqLExHhnaoGxwwD4eVMuREz06ELDQMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5NT73S2NWrcXpag/dJ3/5HFPf0qWGd+FpujnWNgJPEj2IJZ01soCvrUggOzLO/ME8M4vCEtqLjTcOvlFEWKe+nbDU4wy/OOVwSY+GjAffLShWHDUivqXqOaYgGB/wBsjRlSQ6rLFtJqi5JWl6Kh/sUuLkEvOi8wbVQnJ1vsmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=NjjbSXCA; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=oZU94zf4qOJWw3Y2ZIiCNprOQcuL1l2VPK5OelIsrbE=; b=NjjbSXCAQtBGV5wQLLT7IUmjFO
	/jNi0fedqCva+rqPsXLMO0CSGqxRUt035VdnCkdp5Y5LXQh/6CjwYlFDJ3goM0QMp/m8jDT6JCCvw
	vIzxUOm8xhmIP8jYYX9rN2Fo7aYs2414FUxkT6LKH4KZp+NxeZEYyPVUtwytbX774y2qNbU4pxFrb
	X3ENp4iyL2Js+GdBbQ5CskYw10fk7lsATkBkce87LQO40KzOOlAhbplNDGtYnS90OTNc9X1KKIrfB
	hdC2fihRhu3qJsdA/f3xh0hl6B/U1DZVUbiIZii9p/Wgocavq8jCgFHWHsDxuHhJbrqdBHOqS2Hoe
	9mcA4k/6hegR6do3sVlOCkUTr/1UbcJ/7yknVUkHpLoAKD+sjlQ7f0nzNqU4OdulQL6DCw7vATRR5
	EA7320Xi0X40YhY8LMwk2XAzu4Uz+BuComAyr9sMRHyhPUGD7fwCC1Msppe+QCX7a6ZmD+0SjXNX8
	oW/kPPu/kwBQksz7SzNqUGHt;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uuEft-002S3j-2a;
	Thu, 04 Sep 2025 18:27:09 +0000
Message-ID: <f88d11c2-f716-4f5d-ab37-fec73f2f5d97@samba.org>
Date: Thu, 4 Sep 2025 20:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: server: let smb_direct_writev() respect
 SMB_DIRECT_MAX_SEND_SGES
To: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
 Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-rdma@vger.kernel.org
References: <20250904181059.1594876-1-metze@samba.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250904181059.1594876-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

this is intended for 6.17 as it fixes a deadlock I was
hitting when I run generic/011. I don't know why it only
happened starting last Friday. I first thought it was a regression
introduced by the patches I was working on on Friday, but
after days of debugging using bpfstrace I noticed siw_post_send()
was called twice with the same qp->sq_get/set values while still
returning 0, as a result smb_direct_writev() was waiting forever
for a completion and st->send_pending becoming 0.

         wait_event(st->wait_send_pending,
                    atomic_read(&st->send_pending) == 0);

This requires the patches in for-next-next to be rebased on top
and this will generate some complicts I need to resolve.
Should I post a v5 of the patches or should I provide a branch
that can replace for-next-next?

With this fix the siw.ko patch is optional for ksmbd a usecase,
but it can be found here if someone is looking for it:
https://lore.kernel.org/linux-rdma/20250904173608.1590444-1-metze@samba.org/

Thanks!
metze

Am 04.09.25 um 20:10 schrieb Stefan Metzmacher:
> We should not use more sges for ib_post_send() than we told the rdma
> device in rdma_create_qp()!
> 
> Otherwise ib_post_send() will return -EINVAL, so we disconnect the
> connection. Or with the current siw.ko we'll get 0 from ib_post_send(),
> but will never ever get a completion for the request. I've already sent a
> fix for siw.ko...
> 
> So we need to make sure smb_direct_writev() limits the number of vectors
> we pass to individual smb_direct_post_send_data() calls, so that we
> don't go over the queue pair limits.
> 
> Commit 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
> was very strange and I guess only needed because
> SMB_DIRECT_MAX_SEND_SGES was 8 at that time. It basically removed the
> check that the rdma device is able to handle the number of sges we try
> to use.
> 
> While the real problem was added by commit ddbdc861e37c ("ksmbd: smbd:
> introduce read/write credits for RDMA read/write") as it used the
> minumun of device->attrs.max_send_sge and device->attrs.max_sge_rd, with
> the problem that device->attrs.max_sge_rd is always 1 for iWarp. And
> that limitation should only apply to RDMA Read operations. For now we
> keep that limitation for RDMA Write operations too, fixing that is a
> task for another day as it's not really required a bug fix.
> 
> Commit 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect
> server SGEs") lowered SMB_DIRECT_MAX_SEND_SGES to 6, which is also used
> by our client code. And that client code enforces
> device->attrs.max_send_sge >= 6 since commit d2e81f92e5b7 ("Decrease the
> number of SMB3 smbdirect client SGEs") and (briefly looking) only the
> i40w driver provides only 3, see I40IW_MAX_WQ_FRAGMENT_COUNT. But
> currently we'd require 4 anyway, so that would not work anyway, but now
> it fails early.
> 
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Cc: linux-rdma@vger.kernel.org
> Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
> Fixes: ddbdc861e37c ("ksmbd: smbd: introduce read/write credits for RDMA read/write")
> Fixes: 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
> Fixes: 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect server SGEs")
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>   fs/smb/server/transport_rdma.c | 157 ++++++++++++++++++++++-----------
>   1 file changed, 107 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
> index 6cfca9a00060..3fb1b797a080 100644
> --- a/fs/smb/server/transport_rdma.c
> +++ b/fs/smb/server/transport_rdma.c
> @@ -1219,78 +1219,130 @@ static int smb_direct_writev(struct ksmbd_transport *t,
>   			     bool need_invalidate, unsigned int remote_key)
>   {
>   	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
> -	int remaining_data_length;
> -	int start, i, j;
> -	int max_iov_size = st->max_send_size -
> +	size_t remaining_data_length;
> +	size_t iov_idx;
> +	size_t iov_ofs;
> +	size_t max_iov_size = st->max_send_size -
>   			sizeof(struct smb_direct_data_transfer);
>   	int ret;
> -	struct kvec vec;
>   	struct smb_direct_send_ctx send_ctx;
> +	int error = 0;
>   
>   	if (st->status != SMB_DIRECT_CS_CONNECTED)
>   		return -ENOTCONN;
>   
>   	//FIXME: skip RFC1002 header..
> +	if (WARN_ON_ONCE(niovs <= 1 || iov[0].iov_len != 4))
> +		return -EINVAL;
>   	buflen -= 4;
> +	iov_idx = 1;
> +	iov_ofs = 0;
>   
>   	remaining_data_length = buflen;
>   	ksmbd_debug(RDMA, "Sending smb (RDMA): smb_len=%u\n", buflen);
>   
>   	smb_direct_send_ctx_init(st, &send_ctx, need_invalidate, remote_key);
> -	start = i = 1;
> -	buflen = 0;
> -	while (true) {
> -		buflen += iov[i].iov_len;
> -		if (buflen > max_iov_size) {
> -			if (i > start) {
> -				remaining_data_length -=
> -					(buflen - iov[i].iov_len);
> -				ret = smb_direct_post_send_data(st, &send_ctx,
> -								&iov[start], i - start,
> -								remaining_data_length);
> -				if (ret)
> +	while (remaining_data_length) {
> +		struct kvec vecs[SMB_DIRECT_MAX_SEND_SGES - 1]; /* minus smbdirect hdr */
> +		size_t possible_bytes = max_iov_size;
> +		size_t possible_vecs;
> +		size_t bytes = 0;
> +		size_t nvecs = 0;
> +
> +		/*
> +		 * For the last message remaining_data_length should be
> +		 * have been 0 already!
> +		 */
> +		if (WARN_ON_ONCE(iov_idx >= niovs)) {
> +			error = -EINVAL;
> +			goto done;
> +		}
> +
> +		/*
> +		 * We have 2 factors which limit the arguments we pass
> +		 * to smb_direct_post_send_data():
> +		 *
> +		 * 1. The number of supported sges for the send,
> +		 *    while one is reserved for the smbdirect header.
> +		 *    And we currently need one SGE per page.
> +		 * 2. The number of negotiated payload bytes per send.
> +		 */
> +		possible_vecs = min_t(size_t, ARRAY_SIZE(vecs), niovs - iov_idx);
> +
> +		while (iov_idx < niovs && possible_vecs && possible_bytes) {
> +			struct kvec *v = &vecs[nvecs];
> +			int page_count;
> +
> +			v->iov_base = ((u8 *)iov[iov_idx].iov_base) + iov_ofs;
> +			v->iov_len = min_t(size_t,
> +					   iov[iov_idx].iov_len - iov_ofs,
> +					   possible_bytes);
> +			page_count = get_buf_page_count(v->iov_base, v->iov_len);
> +			if (page_count > possible_vecs) {
> +				/*
> +				 * If the number of pages in the buffer
> +				 * is to much (because we currently require
> +				 * one SGE per page), we need to limit the
> +				 * length.
> +				 *
> +				 * We know possible_vecs is at least 1,
> +				 * so we always keep the first page.
> +				 *
> +				 * We need to calculate the number extra
> +				 * pages (epages) we can also keep.
> +				 *
> +				 * We calculate the number of bytes in the
> +				 * first page (fplen), this should never be
> +				 * larger than v->iov_len because page_count is
> +				 * at least 2, but adding a limitation feels
> +				 * better.
> +				 *
> +				 * Then we calculate the number of bytes (elen)
> +				 * we can keep for the extra pages.
> +				 */
> +				size_t epages = possible_vecs - 1;
> +				size_t fpofs = offset_in_page(v->iov_base);
> +				size_t fplen = min_t(size_t, PAGE_SIZE - fpofs, v->iov_len);
> +				size_t elen = min_t(size_t, v->iov_len - fplen, epages*PAGE_SIZE);
> +
> +				v->iov_len = fplen + elen;
> +				page_count = get_buf_page_count(v->iov_base, v->iov_len);
> +				if (WARN_ON_ONCE(page_count > possible_vecs)) {
> +					/*
> +					 * Something went wrong in the above
> +					 * logic...
> +					 */
> +					error = -EINVAL;
>   					goto done;
> -			} else {
> -				/* iov[start] is too big, break it */
> -				int nvec  = (buflen + max_iov_size - 1) /
> -						max_iov_size;
> -
> -				for (j = 0; j < nvec; j++) {
> -					vec.iov_base =
> -						(char *)iov[start].iov_base +
> -						j * max_iov_size;
> -					vec.iov_len =
> -						min_t(int, max_iov_size,
> -						      buflen - max_iov_size * j);
> -					remaining_data_length -= vec.iov_len;
> -					ret = smb_direct_post_send_data(st, &send_ctx, &vec, 1,
> -									remaining_data_length);
> -					if (ret)
> -						goto done;
>   				}
> -				i++;
> -				if (i == niovs)
> -					break;
>   			}
> -			start = i;
> -			buflen = 0;
> -		} else {
> -			i++;
> -			if (i == niovs) {
> -				/* send out all remaining vecs */
> -				remaining_data_length -= buflen;
> -				ret = smb_direct_post_send_data(st, &send_ctx,
> -								&iov[start], i - start,
> -								remaining_data_length);
> -				if (ret)
> -					goto done;
> -				break;
> +			possible_vecs -= page_count;
> +			nvecs += 1;
> +			possible_bytes -= v->iov_len;
> +			bytes += v->iov_len;
> +
> +			iov_ofs += v->iov_len;
> +			if (iov_ofs >= iov[iov_idx].iov_len) {
> +				iov_idx += 1;
> +				iov_ofs = 0;
>   			}
>   		}
> +
> +		remaining_data_length -= bytes;
> +
> +		ret = smb_direct_post_send_data(st, &send_ctx,
> +						vecs, nvecs,
> +						remaining_data_length);
> +		if (unlikely(ret)) {
> +			error = ret;
> +			goto done;
> +		}
>   	}
>   
>   done:
>   	ret = smb_direct_flush_send_list(st, &send_ctx, true);
> +	if (unlikely(!ret && error))
> +		ret = error;
>   
>   	/*
>   	 * As an optimization, we don't wait for individual I/O to finish
> @@ -1757,6 +1809,11 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
>   		return -EINVAL;
>   	}
>   
> +	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
> +		pr_err("warning: device max_send_sge = %d too small\n",
> +		       device->attrs.max_send_sge);
> +		return -EINVAL;
> +	}
>   	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
>   		pr_err("warning: device max_recv_sge = %d too small\n",
>   		       device->attrs.max_recv_sge);
> @@ -1780,7 +1837,7 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
>   
>   	cap->max_send_wr = max_send_wrs;
>   	cap->max_recv_wr = t->recv_credit_max;
> -	cap->max_send_sge = max_sge_per_wr;
> +	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
>   	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
>   	cap->max_inline_data = 0;
>   	cap->max_rdma_ctxs = t->max_rw_credits;


