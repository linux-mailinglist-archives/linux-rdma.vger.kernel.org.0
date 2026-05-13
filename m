Return-Path: <linux-rdma+bounces-20622-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOq4NYMNBWqBRwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20622-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:47:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8953C1EA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA78F3021BF3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA53CF024;
	Wed, 13 May 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVjn7pyJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188B3CDBA9
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716019; cv=none; b=JmikJs5ZhesJjm4i0UkB+nWVMAif3asCSft/IB/qMy7g0NRDCgyh2MKxcQkwtW2J1jr4fwx/aI99U0/p+b5MIlFvi2e/VvK+kypmrOPdYnPXSvvTEwD69SECSH6Dp2bWnRwDm0jL360AN9uotyekr+8vHvF/uC0gno9jXZQZqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716019; c=relaxed/simple;
	bh=nABnyTVpdpjK5O3wtbrmycZjbC6IhActFaxQTKL0PH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy/WeZNwk+j/ifBXr5upa8lxwVwOpjaNq2bNrr+zmiN7lL+lFrjsoyQVj8zNubksbhLVQU+JwTBD8K6PAUXJzbSTQPD/VC3bebCIPac28H21fkd4oc6XjgliL6rLvnHeBYyc7RWNAQwKalI1AW6vFpjBps9SMK8IqKz0V1Jd1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cVjn7pyJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-910f734b477so12152185a.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778716017; x=1779320817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkTU6tjGG+nOcVlZzdhoBVAzDEp9yyRsCuO17s66584=;
        b=cVjn7pyJuevwdWBS6gPt8TLoDkrW9VAXpoE7Cl1n1yF5qQYP+tjhho9mp/KOcejhUb
         GVy8+HRmlr3ubV07o+9Tkw5Hs3+GFPmLBsbT4Zm0axwX3xT45WeEE5TxBMXgcJpCfapD
         0glamCEwT0CwmffxtXTk3rmHxpq1axM6p48A6HjJm/zYaPAFJUr8nQH5gLEiJHKAy+Ee
         5JB7EPB/JvHsbuV7J525JCN7ck5YKEwfiAW4XSHzvoTg1jcA5sNyoqlSx3Y/AjYKp0qC
         psyTvIntQ7LAIqChx2CNg5D0Q0nGLYxml5PTkqSSxpzgrpXiZ3Aro/3Jhz/fw09x8IM0
         NmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778716017; x=1779320817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkTU6tjGG+nOcVlZzdhoBVAzDEp9yyRsCuO17s66584=;
        b=YXR2UAJ2wFdCH6URPb+MBfB+XNLN9EaK/Y/YWhR6KISZI+VNkod1orK/dqW08x637w
         CCFeCIG7e5wHlvvTfVui/dgcb6GyxmXVe2uit2rH3akyWsZx1Jby9pg+TVI5VqOzW3xa
         HkNBEfVoJc1oQkMd3WePcWoC9LOVkUFAfehyvBkTZuJT7K0NMHMAMlpEoDfeoXmpQ5Ij
         RAnY8y4aUxz+ULYztFpyS8TdcIrQQpZ0TQ5gY37mkoIMjOQCf1loogJ3xjJLwjJqjiGi
         y42p6mS5sTMCEiap0JbqsgXD6JghjX1O4Nyg4iWQLxdG7AAxZu6Lcen3PgkWQwrjGPPU
         xSSA==
X-Forwarded-Encrypted: i=1; AFNElJ+xXUg+95MCZxvXBuA53PNI2pn06sUu0pp+zZSg7GvceJs4q3y0CnhiDHINyqG4eqS5GX1llXDuMBLH@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsuZnjTY8KhhJryix01u/j713uAeaUdA0g/lSmdm8zbIXPwtL
	SnQt3YRHu1kp3Edqs0udPphlmCUXvzZflrq+UCCh1Z7jyLKabr5tdPCS9K2IBrGSfV4=
X-Gm-Gg: Acq92OHkrwZ4g67BUZaZltfRVUnI8bc9ydMbzUJjb2XRpB8MImHxtD05n4sZQkLZ1O/
	6DkbB2T6k/zSv9OsJnRqxEpFsyt/7gKbEDNFNjN8nTL+N70YlKI4oSbrLDO8hc/edjYn4PJob14
	TP3JXOFoyW4KwSEGuiu56qHuk77Nxomp+pFwIrYsQ+fFPtzrsOBlcmARQp4ef62jMP56CoTUkVU
	yYy7WlNsgfJDDKqgqUAbJRD66gI679EKNP+RbkXVESxgluigzyMFIiPDyjb242nCWfNyqZnvqtt
	AO942QH5ip5nDya6svPzMbrsKYK5bxsR8cM33pRXFEXhkK/TQRwAdCrkL+P3stjVnTHUos68txO
	FcAKUxdcxhq5Fg/QYsFeTRRKk6TADk4+NZB0O1tZnt1uzTredWfPB+I1crR1uxnf2LOTdrbqZtx
	dSQiI6mCiGKsOP+UibB7rUvt1YYCMdqTlyz7fHJkPBva4KgIIIeyAitvVHt6ihkwXBRWSy9Ke2d
	sPeqA==
X-Received: by 2002:a05:620a:4409:b0:910:3078:5cf6 with SMTP id af79cd13be357-910307868dcmr532307185a.44.1778716016939;
        Wed, 13 May 2026 16:46:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae27359sm107053985a.17.2026.05.13.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNJHz-000000048gW-3syt;
	Wed, 13 May 2026 20:46:55 -0300
Date: Wed, 13 May 2026 20:46:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
	arjan@linux.intel.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, hdanton@sina.com, horms@kernel.org,
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Message-ID: <20260513234655.GW7702@ziepe.ca>
References: <tencent_611BEB4B141B1A2526BAA3BBB2335F9E9108@qq.com>
 <177869624862.2335447.16979087766093395765.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177869624862.2335447.16979087766093395765.b4-ty@kernel.org>
X-Rspamd-Queue-Id: 7BA8953C1EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20622-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,qq.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> 
> On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > reported:
> > 
> > Call Trace:
> >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> >  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> >  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> >  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> >  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
>       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d

This seems like a rxe bug, I would have expected the lock to be inside
rxe to protect its racy implementation of rxe_net_del(), which looks
like it is possibly also triggered by NETDEV_UNREGISTER...

ie it should not change nldev_dellink().

Jason

