Return-Path: <linux-rdma+bounces-16372-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPuNJeXcgGnMBwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16372-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:20:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCEACF836
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1283D3032F5F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013C385EDC;
	Mon,  2 Feb 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru8wny+a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALHckiru"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E937BE8A
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052800; cv=none; b=atGpCjZs0k8s5zgY5H+ByQ89v5QJz9WBkxgAjWO3WBiF3NCOQoyufxM04ct3PXwX2P2P6jjho/amoebiezqYAXqiAxNepEZV2otQwrK7E5cJt7d+ySzy2LpkA+ne6OBaRF4AW2jd/jw6mMU+cmt8EcFwbYtiSHVXwrSjKLmBxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052800; c=relaxed/simple;
	bh=sg7r2bggyNeKqLAfbEeFBVcgdfvWyCSGQHXTajmTCS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtTXKfiZCfpE04nctQpD3ImVt2t9RPR6cWge+4V0KCl4yyBdN2x1kl33K2BT/0ZaEC9TWsRDQ1BbgZ4iJ0A0zM4FARhF1tCZAus9Pg8Yp8B/ykJYes2KVjt4LmJtC7BTMn2tW3jz3HsEj3QiZDiLAimbuyO9qjd0GSp8r7I9OB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ru8wny+a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALHckiru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770052797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueRmNBsULHX80WZv6MW3ddncHXPCqgI+9LkeT0jMc9E=;
	b=Ru8wny+avuOYn/24ln9rRybEEL+TosE9X/sn0ESESfwb5q5ba8MplUOHhW0VN60AZc9wjV
	NHHo0Apn4MyWnbLAYPWAltdwFe8LB+ryhLaqhMcGYsW/+JQqJd2sYxz56YZ6BFRmAsGeds
	X2J1U2IfjGVT7FGF/tN1sDl9c663cGY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-81eMFQqaPF-G49UQg4jppw-1; Mon, 02 Feb 2026 12:19:56 -0500
X-MC-Unique: 81eMFQqaPF-G49UQg4jppw-1
X-Mimecast-MFC-AGG-ID: 81eMFQqaPF-G49UQg4jppw_1770052795
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4325b182e3cso3213891f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770052794; x=1770657594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueRmNBsULHX80WZv6MW3ddncHXPCqgI+9LkeT0jMc9E=;
        b=ALHckiruESfNzZ7hHsXUXRLtVe7//5gK/OLLXESaB9pB5FBdAZdGPXf2bqNy7dC7g1
         eRb0O1xS0E2jYlIjbYSkN+Qne0asRv6XoXyNTGzDkYDwV4b016xgvpGmJSOhOaYQKvAm
         M3XMRwQHDSH2aA5qzVtNOQ/AKEVF5zfTdS2drgB3FA7fefqI1B5xAXvsMQjpYYGV6f+P
         kzT0Wqgb4kRjHiaY+HzgdcSeHCH9vvZzYAe/Fw8JltI19I/2bvPBN2UfMH5AIcJYV3CK
         xfOf/smPA0Ke/MVI9+1gd47Xcu5naSCSPygRNptpbZ0AEHVY6PhYzfZ/kHYMdaQH5CLd
         xLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770052794; x=1770657594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueRmNBsULHX80WZv6MW3ddncHXPCqgI+9LkeT0jMc9E=;
        b=YnhTgt6BLMV4oyHfMO9JnkQEo1eD/Nx8LdHekKH7mVkJNw1xfLCvjdNzPCHAXtU9pk
         hxL/AAw1zhCKaiiL4V8lDCKyT+pVqKZUusBfLElgXNCRQe5t0h3kLybqo8XNBY9kFWit
         Ti6S1N3aFFHegvz/QxZL5sik1HcE2eSh+gb1+/I9d9qfEJAU+LRFDesppY3hqO+L7Bab
         51Ch7vToLGlT4YTkkvgxAvFYtHOo/f5pHAwtf7xuwbZ9mHrSKJwnqtvA8pN4FC/JOaME
         o7FIqD+fx4jAI9iKp9y/zaTBt7xLSM/My8c5uPi/DAJY+co+QQIWV52tzANYjbRExo0G
         Regg==
X-Forwarded-Encrypted: i=1; AJvYcCVFRfd/R4BXKwB1nIdPSqdE/h6xQydXil5VXLCUjfrZMZ4v8zW+crVG+K+DixhLLp6CZKMlBFVhMhL+@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrbsb8O41hIpBxrzDagZ5OdDq9N1trQHwo58Zx10iiomNPzfy
	UKC5ddAn7/iX9LDOyTTgqF3mvKKWRQRy5t6FbzYu+P8GjHYKpT78nTZiHwdtDfQn8KtlGn8Njfg
	fTmy4c95UtR+fyOBVs0WPupq7J2T2kMf7IZNGPCZt14xso/GZP+cJ/YboTvj2+vFS5LuJ0hI=
X-Gm-Gg: AZuq6aJenhfs0nKbSmWCiSoB1Xgl4YzPGcTFBk1f/M+hXlbT2grzB/p+57DT7A7dM7I
	aTtuoZDTBYdL3Y010xyOhL6iGkmmUfWLYhAfRPcoYTIRtL8wmgmjPrDxw6G2C4p9xde2O2elQCg
	LkQuUUjTwKDOWUsZZPoDmMmuDLS0+3XkiSQXZyh5MoEKmLJzZA9HanQtiMNwGDeFruhKmoOxnn9
	rtjkrPAt2QRJwf38vpMEICFoqqWmBMVTql2Ij6yzbFGJYwpGTN18yegMFly7Jz5Aj+nFgUPpLrV
	Z/z/7PJpSAfJ1lT8Q4bmcJin5pYHcO/8EVAe+N/ghVe35IkUBjeMdz0KsqdIqKqSaApAYr3Z4xv
	3Q+GAvg==
X-Received: by 2002:a05:600c:c4a5:b0:47e:e946:3a59 with SMTP id 5b1f17b1804b1-482db4992d3mr133150205e9.34.1770052794326;
        Mon, 02 Feb 2026 09:19:54 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:47e:e946:3a59 with SMTP id 5b1f17b1804b1-482db4992d3mr133149375e9.34.1770052793718;
        Mon, 02 Feb 2026 09:19:53 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48305129419sm2637285e9.6.2026.02.02.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:19:53 -0800 (PST)
Date: Mon, 2 Feb 2026 12:19:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Message-ID: <20260202121830-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
 <20260201035912-mutt-send-email-mst@kernel.org>
 <AM9PR07MB79696F945D8DBEF370CD4DC6A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM9PR07MB79696F945D8DBEF370CD4DC6A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-16372-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFCEACF836
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 04:56:38PM +0000, Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>=20
> > Sent: Sunday, February 1, 2026 10:18 AM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com=
; shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@=
nvidia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; ja=
sowang@redhat.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.c=
om; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@vge=
r.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@=
google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.co=
m; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wan=
gcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.=
ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@k=
ernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google=
=2Ecom; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.=
white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@eri=
csson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=
 vidhi_goel@apple.com
> > Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in v=
irtio_net_hdr
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > Thanks for the patch! Yet something to improve:
> >=20
> > On Sat, Jan 31, 2026 at 11:55:10PM +0100, chia-yu.chang@nokia-bell-labs=
=2Ecom wrote:
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the AC=
E=20
> > > field to count new packets with CE mark; however, it will be corrupte=
d=20
> > > by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied b=
y=20
> > > seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be=
=20
> > > changed within a super-skb.
> > >
> > > To apply the aforementieond new AccECN GSO for virtio, new featue bit=
s=20
> > > for host and guest are added for feature negotiation between driver=
=20
> > > and device. And the translation of Accurate ECN GSO flag between=20
> > > virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to=
=20
> > > avoid CWR flag corruption due to RFC3168 ECN TSO.
> > >
> > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >=20
> >=20
> > To the best of my understanding, this is a new feature - support for VI=
RTIO_NET_F_HOST_ACCECN, VIRTIO_NET_F_GUEST_ACCECN?
> > The commit log makes it sound like it fixes some behaviour for existing=
 hardware, but that is not the case.
> >=20
>=20
> Thansk for the feedback, I will update commit message in v3.
> >=20
> > > ---
> > > v2:
> > > - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
> >=20
> > but where is v2? this is v1...
>=20
> I shall update this version as v2, will do at the next version.
>=20
> [...]
> > > diff --git a/include/uapi/linux/virtio_net.h=20
> > > b/include/uapi/linux/virtio_net.h index 1db45b01532b..af5bfe45aa1f=20
> > > 100644
> > > --- a/include/uapi/linux/virtio_net.h
> > > +++ b/include/uapi/linux/virtio_net.h
> > > @@ -56,6 +56,8 @@
> > >  #define VIRTIO_NET_F_MQ      22      /* Device supports Receive Flow
> > >                                        * Steering */
> > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > +#define VIRTIO_NET_F_HOST_ACCECN 25  /* Host can handle GSO of AccEC=
N=20
> > > +*/ #define VIRTIO_NET_F_GUEST_ACCECN 26 /* Guest can handle GSO of=
=20
> > > +AccECN */
> > >  #define VIRTIO_NET_F_DEVICE_STATS 50 /* Device can provide=20
> > > device-level statistics. */  #define VIRTIO_NET_F_VQ_NOTF_COAL 52 /* =
Device supports virtqueue notification coalescing */
> > >  #define VIRTIO_NET_F_NOTF_COAL       53      /* Device supports noti=
fications coalescing */
> > > @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {  #define=20
> > > VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
> > >                                      VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IP=
V6)
> > >  #define VIRTIO_NET_HDR_GSO_ECN               0x80    /* TCP has ECN =
set */
> > > +#define VIRTIO_NET_HDR_GSO_ACCECN    0x10    /* TCP AccECN segmentat=
ion */
> > > +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS (VIRTIO_NET_HDR_GSO_ECN | \
> > > +                                      VIRTIO_NET_HDR_GSO_ACCECN)
> > >       __u8 gso_type;
> > >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> > >       __virtio16 gso_size;    /* Bytes to append to hdr_len per frame=
 */
> >=20
> >=20
> > UAPI changes need to be added to the virtio spec.
> > Pls get this approved by the virtio TC.
> > Thanks!
>=20
> There were some discussions last October in virtio-comment@lists.linux.de=
v mailing list.


That's it I could not find it. Could you include the archive link pls?=20


> At that moment, it is suggested to make Linux kernel accept new comments =
for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN first.
> So, could virtio-spec colleague give your feedback? (Parav?).
>=20
> Otherwise, the CWR handling of virtio will be wrong after all Accurate EC=
N commits are merged in Linux.
>=20
> Chia-Yu

if there's a general agreement we don't need to block linux on tc
approval.

--=20
MST


