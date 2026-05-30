Return-Path: <linux-rdma+bounces-21540-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPAtKxcnG2qS/ggAu9opvQ
	(envelope-from <linux-rdma+bounces-21540-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 20:06:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B111E610FE6
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19AF53012545
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4403348C5E;
	Sat, 30 May 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW0s6x5q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511A29B78B;
	Sat, 30 May 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164304; cv=none; b=KIodVAQLP37wZBhajkHc7gxwMF8wW83zQilvlzxn0mEN+bjHlLlf4tpHO2oMzStFviCSKMQ8spIkzRiCTbO94vCLfYnlw2fZqLGf42jroH38Dk7NvvfflEfKyM28ZuZ/XNg3XAgNnV+Ya4SXk9G2+5xl61WNp15S1qwU+wYw/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164304; c=relaxed/simple;
	bh=iFoB49l26PQzgAd+2lC7D6V+iOm8XQrDlyTVU4zeqcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKeIIQFx4I824oTbKRftHDXtJk8Zp/9ouK30oGKFbkAg0XxsGAC/cZxaEO7utoYo6BktMnpc5r3lOAjEALclTj2scAKyNJgnkm+OdzeacGZoQJsRzTMH4I9JR+mk0xNmnAFKWdbTLJ4XqjJBjyM+qi/tvIggvmgf70nr0DkJakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW0s6x5q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E41F00893;
	Sat, 30 May 2026 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780164303;
	bh=fAjDYJv3ZqoP4U3LWt0qIvFrrnx+oJme8aCuzuadrIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kW0s6x5qXQMvaoQ6ncHzWrw4+BhHDGeSuccj0kmyw6zG16h/oDqKh3KNGVaDRtEXC
	 MagaRRBGIKnFhoR6nuxiHm+ZpCFKFQduAiTUNHweeZGQ+kZBBIMdyxulurYjF5eVVV
	 PeaeoEG4oT/WnlkhPru8ayW2owVJCFLt9LRtO4W30lyzvMx1C3TfUxAnjegNqf9OYy
	 q+8nZMROrh9ix4jV5GUWwoVU+O7XWlsKkNlhRCIx94qCC7ub46PEvreDvLoGA5t6Dg
	 FFKErcb1SNmt9bzjrkn/AQgRnpZdS8OtADRULOcln+K2c7qasTy6IeW7mP60dAq2yd
	 bKVUc+6sSWOnQ==
Message-ID: <d6f47527f97af2ba8fcbd08cf1bcd49f11124eb9.camel@kernel.org>
Subject: Re: [PATCH net 1/1] net: rds: clear i_sends on setup unwind
From: Allison Henderson <achender@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: yanjun.zhu@oracle.com, guanglei.li@oracle.com, davem@davemloft.net, 
	santosh.shilimkar@oracle.com, junxiao.bi@oracle.com, yuantan098@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, xuyq21@lenovo.com
Date: Sat, 30 May 2026 11:05:01 -0700
In-Reply-To: <5a0f7624bb9845a7b67d26166a150b59e7f394ce.1779632468.git.xuyq21@lenovo.com>
References: <cover.1779632468.git.xuyq21@lenovo.com>
	 <5a0f7624bb9845a7b67d26166a150b59e7f394ce.1779632468.git.xuyq21@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21540-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,davemloft.net,gmail.com,lzu.edu.cn,lenovo.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lenovo.com:email]
X-Rspamd-Queue-Id: B111E610FE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-29 at 21:01 +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
>=20
> The RDS IB connection teardown path is written so it can run during
> partial startup and on repeated shutdown attempts. It uses NULL
> pointers to distinguish resources that are still owned from resources
> that have already been released.
>=20
> When rds_ib_setup_qp() fails after allocating i_sends but before
> allocating i_recvs, the sends_out path frees i_sends without clearing
> the pointer. A later shutdown pass can still treat that stale pointer
> as a live send ring allocation.
>=20
> Clear i_sends after vfree() in the error unwind path so the existing
> shutdown logic continues to use the correct ownership state.
>=20
> Fixes: 3b12f73a5c29 ("rds: ib: add error handle")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Hi Ren Wei,

Looks fine to me. Thanks for the catch!
Reviewed-by: Allison Henderson <achender@kernel.org>

Allison
> ---
>  net/rds/ib_cm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
> index 0c64c504f79d..4001de0c4959 100644
> --- a/net/rds/ib_cm.c
> +++ b/net/rds/ib_cm.c
> @@ -656,6 +656,7 @@ static int rds_ib_setup_qp(struct rds_connection *con=
n)
> =20
>  sends_out:
>  	vfree(ic->i_sends);
> +	ic->i_sends =3D NULL;
> =20
>  ack_dma_out:
>  	rds_dma_hdr_free(rds_ibdev->dev, ic->i_ack, ic->i_ack_dma,


