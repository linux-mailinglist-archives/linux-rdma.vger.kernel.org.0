Return-Path: <linux-rdma+bounces-22576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dQ6yHclWQ2o5XAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 07:40:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF56E0809
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 07:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=OTkQjakl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22576-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22576-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9DD300D68E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857003CC314;
	Tue, 30 Jun 2026 05:40:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6B40D598;
	Tue, 30 Jun 2026 05:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798019; cv=none; b=V4YtD/6w7n7/g+wet4qftE74JuZBl9GJ+sO3IXvWH1t85WKubiWC8Dw+qv9PsJtvKHoyMDHeycBVzPfF3ChrA7JZqLEf+3VFO2xq3O+clRa8MFD8rka3OztCbHqibGla+TE6zJo+nA73z5HgOmanUHytmYfhUTrcferop8nyLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798019; c=relaxed/simple;
	bh=vXWDosCj/bEpPUnhj+dIL4/zCzKTAtO8MdXAxsdqyk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2i1dkSx0/W3eJtQHpv2B23TeWHsZ2eNa5clGxapfuF75sHYYguDzmVhsYCdsMfxwDUMGeYs/yoaQZNcBQOecV2yrl1jXo4L+JDculTbiWukunFRYv2lUXX92bjoBy7y92TzBH4A8vzxyaVIpnAkJp8W6LcolkZ23SxWh8oHnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTkQjakl; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1J48s604813;
	Tue, 30 Jun 2026 05:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g4PshD
	nQGifGrRZWPS7WQ55Vlrc1WQWCSGimRfux+Vw=; b=OTkQjaklbaRk/p1z3p4EBX
	rEcTrzHkqI22eAqVCC9x7bAwvTfrfSLCNrqO/w6+W7nM0urElYDWujeznkNUpQhg
	BgBbWpY61ET4A4FMp2Y7R9FP0zvh4tVwZMBxt+jvmOMkZD3xfFiybEAvJQTzIVlN
	gatHdeKEUceI7W/suiafvT7nu7GN7gDp9M4HdpW18bG7CNVOC3SkgBh0FTeQNAl4
	Xw2P0AZOpkP6GvmxvQWs/AeaPz/YL0RlwrmJKtImv58Bc7xiJtAf/KXl3d47bVng
	sncykt88PFwH7cbOKjUgcF/fgggF0uw0COEyiRX6tfdX8DzI/8tnSHnr7rfb7rWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5n029-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 05:40:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U4nio9001655;
	Tue, 30 Jun 2026 05:39:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w0sg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 05:39:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U5dtfw39977312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 05:39:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50B3E20043;
	Tue, 30 Jun 2026 05:39:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2C120040;
	Tue, 30 Jun 2026 05:39:52 +0000 (GMT)
Received: from [9.123.14.166] (unknown [9.123.14.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 05:39:52 +0000 (GMT)
Message-ID: <cbd7c6c1-15e9-4a9a-aaca-4cbb5bd157c7@linux.ibm.com>
Date: Tue, 30 Jun 2026 11:09:51 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix UAF in smc_cdc_rx_handler() by pinning
 the socket
To: Xiang Mei <xmei5@asu.edu>, "D . Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Hans Wippel <hwippel@linux.ibm.com>, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
References: <20260627014948.3049512-1-xmei5@asu.edu>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260627014948.3049512-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX7Qg5o8zlCcqK
 gMbnofeOYwNdtkRyIt+Bd750yQpENOG5p9zJsuVWqBvBo3fHEsJS+/9mS6Zn7qYHnQxTwCLkYZL
 gFFWulMtp7eWklDU3uRqf5RgIW5FYuwiNun+55LsLL/AUaAsw7rnfuAbuIYCxv+mZCc7gjKQYFe
 oZO8qEHFf/s9wqsvxDZTWtbQ7tHb3RjJBpSn+rSVS+88u/GkzjvA0JKuvqzmc5F4AxCzKMrfMGD
 1U+fud83XCEdELa2Fe+c6iS8zu6Mv+e+bstdVciDNuIrzuv9pN2w+L2yRRgf96qz1vLho+cLrcV
 t0aL+lZv1sWvpUzBXfwN9SHyS76N+WMbF35mniV9wGhaxNCp982oNwgsKXZdcem0rZvstkYssfL
 cGqcOlzFRmAXG/yVgV4YEqbUe9TCdWM/cPoMyCYyJBl77uwnVVO2mjGmZOiMDtXxQTvhY+xA3L4
 9hHXlhD8wrc6zNO5RAg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4356b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=zYt0pC7vdrQuDdVn6b0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H4ZC4TtX4_rnk-MdkAhlh3HOr1V24ivu
X-Proofpoint-GUID: l6QIz4z4VmTzOEOFTHl13FicSHXCeDhu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX/NhcRf+etnto
 yjDY7b1QTMkVU81m0C03CXhj7kGc4c75NpUIC2cDvaEIQqmZvMiN43wpr/qS6e2YEFhrs3KxZ3B
 DEoReDldggsJ3vINicU4azrX/qk4wm8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-22576-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hwippel@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4FF56E0809



On 27/06/26 7:19 am, Xiang Mei wrote:
> smc_cdc_rx_handler() looks up the connection by token under the link
> group's conns_lock, drops the lock, and then dereferences conn and the
> smc_sock derived from it, ending in sock_hold(&smc->sk) inside
> smc_cdc_msg_recv(). No reference is held across the lock release.
> 
> The only reference pinning the socket while the connection is
> discoverable in the link group is taken in smc_lgr_register_conn()
> (sock_hold) and dropped in __smc_lgr_unregister_conn() (sock_put), both
> under conns_lock. Once the handler drops conns_lock, a concurrent
> close() -> smc_release() -> smc_conn_free() -> smc_lgr_unregister_conn()
> can drop that reference and free the smc_sock, so the handler's later
> sock_hold() runs on freed memory:
> 
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate
>   Workqueue: rxe_wq do_work
>    refcount_warn_saturate (lib/refcount.c:25)
>    smc_cdc_msg_recv (net/smc/smc_cdc.c:430)
>    smc_cdc_rx_handler (net/smc/smc_cdc.c:502)
>    smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445)
>    tasklet_action_common (kernel/softirq.c:938)
>    handle_softirqs (kernel/softirq.c:622)
>   Kernel panic - not syncing: panic_on_warn set
> 
> Only SMC-R is affected. The SMC-D receive tasklet is stopped by
> tasklet_kill(&conn->rx_tsklet) in smc_conn_free() before the connection
> is unregistered, so it cannot run concurrently with the free.
> 
> Take the socket reference while still holding conns_lock, so the
> registration reference can no longer be the last one, and drop it once
> the handler is done.
> 
> Fixes: d7b0e37c1ac1 ("net/smc: restructure CDC message reception")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/smc_cdc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab3824..b809139d7e87 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -483,21 +483,27 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
>  	lgr = smc_get_lgr(link);
>  	read_lock_bh(&lgr->conns_lock);
>  	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
> +	if (conn && !conn->out_of_sync)
> +		sock_hold(&container_of(conn, struct smc_sock, conn)->sk);
> +	else
> +		conn = NULL;
>  	read_unlock_bh(&lgr->conns_lock);
> -	if (!conn || conn->out_of_sync)
> +	if (!conn)
>  		return;
>  	smc = container_of(conn, struct smc_sock, conn);
>  

Fix looks correct.
A few nits on the implementation:
container_of() is called twice for the same conn. The conn = NULL
sentinel and the second post unlock check can also be dropped. Flip the
condition, early return inside the lock, compute smc once:

	if (!conn || conn->out_of_sync) {
		read_unlock_bh(&lgr->conns_lock);
		return;
	}
	smc = container_of(conn, struct smc_sock, conn);
	sock_hold(&smc->sk);
	read_unlock_bh(&lgr->conns_lock);

Also please initialize smc = NULL at declaration, it's not a bug now
since the early return guards it, just to make it refactor safe.

>  	if (cdc->prod_flags.failover_validation) {
>  		smc_cdc_msg_validate(smc, cdc, link);
> -		return;
> +		goto out;
>  	}
>  	if (smc_cdc_before(ntohs(cdc->seqno),
>  			   conn->local_rx_ctrl.seqno))
>  		/* received seqno is old */
> -		return;
> +		goto out;
>  
>  	smc_cdc_msg_recv(smc, cdc);
> +out:
> +	sock_put(&smc->sk);
>  }
>  
>  static struct smc_wr_rx_handler smc_cdc_rx_handlers[] = {


