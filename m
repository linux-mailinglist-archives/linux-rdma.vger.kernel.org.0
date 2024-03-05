Return-Path: <linux-rdma+bounces-1208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F70C871187
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 01:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B59281921
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F7E1373;
	Tue,  5 Mar 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Afl8z6C3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F9EC2;
	Tue,  5 Mar 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597919; cv=none; b=n3CJAyZVhWtrllIVQtBbPD2oC7zLzIw+8n8IC5LfE30u/+IFiS4IOWiKaTATHvdV2dQNzGMjvt5JCYm58XDeA1MYuVLSB1ho1ZwhDk1N4EoiVqpZQBgIyEgRNodQBEhJzTmi3a1e/O5PaVjTXJe7xPZv+74omR8la3IGTXQYs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597919; c=relaxed/simple;
	bh=EnwZhMrrUcc4yblMq+OlQfv45vQRmmbgt+i2+cP0rA0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Xd/3fZi/m9/+p9/Al9JgI44DHA6Gd5F9DsQdQ37LUlseHiSWyvEq2oIv3VInG8ZpMSDCNdJTOTvVAVOppFa6LM7KrLQsCkawm/Qr5AH9Y2fawaS59EtFmMNRagdITAumQXM8Jb6iiDXz1naO+GX/EaaTBItrzX3pNkNjGbgBb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Afl8z6C3; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709597908; bh=mdlv0km0+x+nxByXOb0/Ng4kSGbELBYlCOniiMmhN0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Afl8z6C3z1JDUT+J4EfnWdRxzzE3/Y5TCCs0mRWoY8TlP0kc8QcD3sz+pkrRHo5Xw
	 UNSX1nCU+rtH3Aiy7uVje0T73JgQmn1uz15JKsTDs/4g7/iE6vHJeqGmlJVtTm5+xH
	 SCeXfFE8fSg/ckY0XOqJJyvs1akVT0n0Nycru3ds=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 30214820; Tue, 05 Mar 2024 08:12:02 +0800
X-QQ-mid: xmsmtpt1709597522tok1j11gq
Message-ID: <tencent_A0E364097003A96459B76B577166D5F36505@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/07fM0cr44o/a/HoahtBTBXEv7iONF8UruOV+iLBbVhWwEeHrPm
	 1VvBBnd3lPlzkxF2Chgvgm3wfSgR0HuJw+yGhYZj96rYTq41D9keSSo/mh1ur6VstD7VXG7MSIqG
	 16c1ysyULwDErEl1vwqkpUId4F1gVgtJVZKzgg9liMjCoJq6cAT01IhY/K3oHKvDEZK52OLIRQ/L
	 UzEOuxS6Qzh8zvXOSkjrTl3woes2lcAanTZ7HCiiCZF3VixH353ZMvMhFEG4OX4cusL8bebzkkPW
	 VltJBrR4gfS8RNgRWH+i+Y+/GQDPFB0L3Ti/yC4gnuttLKYXczpKd5rg88uKu4+aQ8DMjqDVRma7
	 oXim/bm+N8hJ8E4uyKXj7Zujr1d/zlvqCCXoGuBVTsSL7ugVs5mYFy5m2xBiqebyNPizCUlrGstG
	 98rn4NB+RoF8X4gOA412t5zzA93bRPmtEAC+2pqz66iBso0nQZIsNqfv453cHqVSUaxBaboPCP/w
	 tRrBhY8lh668E5Eqb+tMj+RMNznlJSa+S/xJJ7EOtZbrb5m4j7ztaDzcAIUe6gXQjOo4O6W5KIYF
	 zwgXUWYCxScoaeXa3jNIeqFtniiJEKnDeHfaQR9VHmSc1Bx7cMpa7AXPbJP7S37xwEQmiK4BGJhe
	 DWaN7JyE+TB7lCWdffzxbq+bXxJZCSBe4wN0QSMG/olesrNEUu8Wmqca+y3pGAPoBF4Xd49AP6pD
	 NX1PjvtJowHPoWOsdxPMIQeOSj5rjyKTO00TGQvMiMCT5VVsE+dK7Z35Nq444sKNko5gkHexCWHq
	 nLH40J3AXGoJcDF7B3hpxgSmr9tziao9VTUSpoL4cIBDdpepkkcBW+SCvF7CO8qr1Y6+9MuSYKO3
	 AZyxMhGh8J6rgjj9BLE7UAzHiZ19MOTZFIwZlIoioK/O+nWaBmD5Vn4SrNSzW0Ui+irV2J/+M3Iw
	 ssIAEQqhQusVhH/TanjQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Tue,  5 Mar 2024 08:12:03 +0800
X-OQ-MSGID: <20240305001202.2240314-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304170707.GJ403078@kernel.org>
References: <20240304170707.GJ403078@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 4 Mar 2024 17:07:07 +0000, Simon Horman wrote:
> > If connection isn't established yet, get_mr() will fail, trigger connection after
> > get_mr().
> > 
> > Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures") 
> > Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/rds/rdma.c | 3 +++
> >  net/rds/send.c | 6 +-----
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> > index fba82d36593a..a4e3c5de998b 100644
> > --- a/net/rds/rdma.c
> > +++ b/net/rds/rdma.c
> > @@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
> >  			kfree(sg);
> >  		}
> >  		ret = PTR_ERR(trans_private);
> > +		/* Trigger connection so that its ready for the next retry */
> > +		if (ret == -ENODEV)
> > +			rds_conn_connect_if_down(cp->cp_conn);
> 
> Hi Edward,
> 
> Elsewhere in this function it is assumed that cp may be NULL.
> Does that need to be taken into account here too?
Don't worry about this, if it is NULL, the get_mr() return value will not be -ENODEV.
> 
> Flagged by Smatch.
> 
> >  		goto out;
> >  	}
> >  
> > diff --git a/net/rds/send.c b/net/rds/send.c
> > index 5e57a1581dc6..fa1640628b2f 100644
> > --- a/net/rds/send.c
> > +++ b/net/rds/send.c
> > @@ -1313,12 +1313,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
> >  
> >  	/* Parse any control messages the user may have included. */
> >  	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
> > -	if (ret) {
> > -		/* Trigger connection so that its ready for the next retry */
> > -		if (ret ==  -EAGAIN)
> > -			rds_conn_connect_if_down(conn);
> > +	if (ret) 
> 
> nit: checkpatch warns that there is a trailing space on the line above.
I will send a V2 version patch to correct this warning.

BR,
Edward


