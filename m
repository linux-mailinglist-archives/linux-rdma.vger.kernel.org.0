Return-Path: <linux-rdma+bounces-16303-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4hasLD8af2nGjwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16303-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:17:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9EC552D
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92F7300DE3B
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453931D362;
	Sun,  1 Feb 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMFwtY5D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9teKUJW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8882E6CD2
	for <linux-rdma@vger.kernel.org>; Sun,  1 Feb 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769937467; cv=none; b=C8VD8gKuii82vsJkK9V7cIhepg0EgpBEZC3UvRB1AVT1hc3yje2SoVt1iiSEoa2ftxr+tCUS010zB0fZsoQa7yH1Q7aNsBAVJ9vzuU0v0PS6crZgtkF3WRg7ogIDlePC2bvqcuoMB4N93jfkFJLIkl1iEA3I30YiPN7u88emmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769937467; c=relaxed/simple;
	bh=LaKEqrgvYkhsFwqyindBMnW1p2HUBq4DbwnLjR4F0Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSNwTIhDlVhixALScRT7vJqGTpu3SeqkrOzf54h7c3eJeJoc01WS366AV5k4kwoOw2m4UZsRuqhQ2do9c3piSpPr3GttENBp9jbyKPvWVxitbz7RRu2j0gJAfVKKxbeeror7b4V1rQpUvo98O7l0jMUIDv1zpOGOA+CevM/rzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMFwtY5D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9teKUJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769937464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1F5jlC4KkSLd9axs6reavDIsao7rIgQww1rrTaK/DA=;
	b=ZMFwtY5D0nzd7Rwx24Llyd63vm7hRPECVEJRDLS4JD0U/MlcwMU8150DsyqP4unL2zk2QH
	UNsY8llyJATtkZwsUjzx97MASvD6xSVy9higavJCL5KL5GxxqA4S30xq0mPXVY6PZLE5fB
	z/GNPKAzBJeQhKZTBHVxQkUGtXlj0SA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-45FwaJWvNfOMh_D_YhVc1A-1; Sun, 01 Feb 2026 04:17:43 -0500
X-MC-Unique: 45FwaJWvNfOMh_D_YhVc1A-1
X-Mimecast-MFC-AGG-ID: 45FwaJWvNfOMh_D_YhVc1A_1769937462
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435db9425ebso3781151f8f.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 01:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769937462; x=1770542262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1F5jlC4KkSLd9axs6reavDIsao7rIgQww1rrTaK/DA=;
        b=g9teKUJWmIzv/YgFxs39Hoalac8WQQJPdt107OW4pXtEuUor7a5B9Rj5vqSNoNgAkq
         vSlkUQ7qa36Zrls1J/kwCVyA3cTTG5Hni3IX78LwWUcHCdlfxBZTQ3JFKtGhd3tUgbPn
         cDC6piFB7ylW9ABQNIDmkA7APgPltel6CcSAyJxth1f1qTfmc0yppwOdvAQbE7bKuGbo
         myG1p6y/eNJ4qOz/tTEHR1OPDB5gG65OfIkKvXMBVHjWlvpY2jNCTz1qXSCDjIz4JPHb
         6CP5hgWYUbQ66smXlP52Kp6Ov+3ngDYIPh0csoTfzjAF3/tLo+0nNpTRpIBMcMfhun+F
         Z/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769937462; x=1770542262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1F5jlC4KkSLd9axs6reavDIsao7rIgQww1rrTaK/DA=;
        b=K/IAzwAoqtLK7tl6GNWSHyHaXRClTnWX4NuqbdhbVUEBfHMrVDB06D3OvjVW1eHWpR
         bqBECEpozMoAadC2qtWo1Gyduffo1Wh3PAqyME4mM+ktEo9INjE+U47VJPFDIg22f7Ki
         sZ+SIY1+crPtvZyJsIH/QsgWnEC7JP9uWhTH3F3+BIpNewGZFOXqxuS2p/+gk7ofR3+U
         /s4nR77fDkDiseVSfnfNVmQDThYMeukyaI2B+Iz9GyQYXaUaO6qEiOhCrdyeR8/+/qsr
         dnjWtBHN7+jneBzCXAI4bHexyyaiEKPI946/SpSSz0zRbW+lRj02Zsa3o7wNJ+PAliZJ
         RA1w==
X-Forwarded-Encrypted: i=1; AJvYcCUg2iFnhFWX8WD17GL19Db1OzjnNhdsdob+oW2Xuk03qLBAgpxp6Kt1YKEcvOO7aul2ICS/4mANG06M@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+H5YnZqYbW5oTfg6a/+SpVeFsn3NARfPWSMJfnoSuSLzseee
	G/4HhCzIJb3gOchB0M5LbGnOcLo20pweV/BzYAapTm2wrqMX8ZepfPp4bwLnpNjxbDaLdmHxbxI
	kUiFRO/ZwBb2hi6RURJ4NHPhE/hen5IRvjy5iMG9O95QolKD87r/Opcve/gIqbbQ=
X-Gm-Gg: AZuq6aINqNemrSEQejpkE0cA9igp8Ed4f9wp/KgVo5Vjw6BLsPVc+LZ/hLvtM8eRYco
	OEzQj3M7LehX9wpxvpHe9N77zQrGszMoQeHxWCZLF81Pp8B2uegw3girYQTyxy80I2ffnpf0+sQ
	L+hCXToNr2mPVl8pvt/Dy5iuku2/0pLBeqLlk/VRXkIA+mztPRZTvaX9C3oh3OzVgC1kwS5g7y4
	OiLH6i65Kve3ALHJlU5CKpxr/pwJ5EFvln7LK3L7mhf2UGw5yg1eBp1o/5NnHEV6tAO6QXMnE3g
	PMNWSV1Qth60aubPhTVcZX7MciI13WNvjBo/mBZhfB3FSbMAoUFO5XqgcgNg4lK7eJE7HV6EGX3
	WppUfnsIMOk3whd39uPIPZf4wYOeRAsMFeg==
X-Received: by 2002:a05:6000:4313:b0:432:dfea:1fa8 with SMTP id ffacd0b85a97d-435f3abc65cmr11406043f8f.45.1769937461791;
        Sun, 01 Feb 2026 01:17:41 -0800 (PST)
X-Received: by 2002:a05:6000:4313:b0:432:dfea:1fa8 with SMTP id ffacd0b85a97d-435f3abc65cmr11405975f8f.45.1769937461191;
        Sun, 01 Feb 2026 01:17:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce58sm34407293f8f.20.2026.02.01.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:17:40 -0800 (PST)
Date: Sun, 1 Feb 2026 04:17:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Message-ID: <20260201035912-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16303-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06A9EC552D
X-Rspamd-Action: no action

Thanks for the patch! Yet something to improve:

On Sat, Jan 31, 2026 at 11:55:10PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE
> field to count new packets with CE mark; however, it will be corrupted
> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by
> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
> changed within a super-skb.
> 
> To apply the aforementieond new AccECN GSO for virtio, new featue bits
> for host and guest are added for feature negotiation between driver and
> device. And the translation of Accurate ECN GSO flag between
> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to
> avoid CWR flag corruption due to RFC3168 ECN TSO.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>


To the best of my understanding, this is a new feature - support
for VIRTIO_NET_F_HOST_ACCECN, VIRTIO_NET_F_GUEST_ACCECN?
The commit log makes it sound like it fixes some behaviour for
existing hardware, but that is not the case.





> ---
> v2:
> - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS

but where is v2? this is v1...

> ---
>  drivers/net/virtio_net.c        | 14 +++++++++++---
>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
>  include/linux/virtio_net.h      | 18 +++++++++++-------
>  include/uapi/linux/virtio_net.h |  5 +++++
>  4 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..103fb87c690e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -75,6 +75,7 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO4,
>  	VIRTIO_NET_F_GUEST_TSO6,
>  	VIRTIO_NET_F_GUEST_ECN,
> +	VIRTIO_NET_F_GUEST_ACCECN,
>  	VIRTIO_NET_F_GUEST_UFO,
>  	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
> @@ -87,6 +88,7 @@ static const unsigned long guest_offloads[] = {
>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +			(1ULL << VIRTIO_NET_F_GUEST_ACCECN) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
>  			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
> @@ -5976,6 +5978,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
> @@ -6635,6 +6638,7 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>  	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>  		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
> @@ -6749,6 +6753,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			dev->hw_features |= NETIF_F_TSO6;
>  		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
>  			dev->hw_features |= NETIF_F_TSO_ECN;
> +		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ACCECN))
> +			dev->hw_features |= NETIF_F_GSO_ACCECN;
>  		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
>  			dev->hw_features |= NETIF_F_GSO_UDP_L4;
>  
> @@ -7169,9 +7175,11 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
>  	VIRTIO_NET_F_MAC, \
>  	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
> -	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
> -	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
> -	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
> +	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_HOST_ACCECN, \
> +	VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
> +	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_ACCECN, \
> +	VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_HOST_USO, \
> +	VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
>  	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
>  	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
> index c328e694f6e7..90bd95db0245 100644
> --- a/drivers/vdpa/pds/debugfs.c
> +++ b/drivers/vdpa/pds/debugfs.c
> @@ -78,6 +78,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
>  		case BIT_ULL(VIRTIO_NET_F_GUEST_ECN):
>  			seq_puts(seq, " VIRTIO_NET_F_GUEST_ECN");
>  			break;
> +		case BIT_ULL(VIRTIO_NET_F_GUEST_ACCECN):
> +			seq_puts(seq, " VIRTIO_NET_F_GUEST_ACCECN");
> +			break;
>  		case BIT_ULL(VIRTIO_NET_F_GUEST_UFO):
>  			seq_puts(seq, " VIRTIO_NET_F_GUEST_UFO");
>  			break;
> @@ -90,6 +93,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
>  		case BIT_ULL(VIRTIO_NET_F_HOST_ECN):
>  			seq_puts(seq, " VIRTIO_NET_F_HOST_ECN");
>  			break;
> +		case BIT_ULL(VIRTIO_NET_F_HOST_ACCECN):
> +			seq_puts(seq, " VIRTIO_NET_F_HOST_ACCECN");
> +			break;
>  		case BIT_ULL(VIRTIO_NET_F_HOST_UFO):
>  			seq_puts(seq, " VIRTIO_NET_F_HOST_UFO");
>  			break;
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..0cf86b026828 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -11,7 +11,7 @@
>  
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>  {
> -	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  	case VIRTIO_NET_HDR_GSO_TCPV4:
>  		return protocol == cpu_to_be16(ETH_P_IP);
>  	case VIRTIO_NET_HDR_GSO_TCPV6:
> @@ -31,7 +31,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	if (skb->protocol)
>  		return 0;
>  
> -	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  	case VIRTIO_NET_HDR_GSO_TCPV4:
>  	case VIRTIO_NET_HDR_GSO_UDP:
>  	case VIRTIO_NET_HDR_GSO_UDP_L4:
> @@ -58,7 +58,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	unsigned int ip_proto;
>  
>  	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> -		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  		case VIRTIO_NET_HDR_GSO_TCPV4:
>  			gso_type = SKB_GSO_TCPV4;
>  			ip_proto = IPPROTO_TCP;
> @@ -84,7 +84,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			return -EINVAL;
>  		}
>  
> -		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
> +		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ACCECN)
> +			gso_type |= SKB_GSO_TCP_ACCECN;
> +		else if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
>  			gso_type |= SKB_GSO_TCP_ECN;
>  
>  		if (hdr->gso_size == 0)
> @@ -159,7 +161,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		unsigned int nh_off = p_off;
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
> -		switch (gso_type & ~SKB_GSO_TCP_ECN) {
> +		switch (gso_type & ~(SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN)) {
>  		case SKB_GSO_UDP:
>  			/* UFO may not include transport header in gso_size. */
>  			nh_off -= thlen;
> @@ -231,7 +233,9 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> -		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> +		if (sinfo->gso_type & SKB_GSO_TCP_ACCECN)
> +			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ACCECN;
> +		else if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
>  		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
> @@ -282,7 +286,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  		return -EINVAL;
>  
>  	/* The UDP tunnel must carry a GSO packet, but no UFO. */
> -	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
> +	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN_FLAGS |
>  					   VIRTIO_NET_HDR_GSO_UDP_TUNNEL);
>  	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
>  		return -EINVAL;
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b..af5bfe45aa1f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,8 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_HOST_ACCECN 25	/* Host can handle GSO of AccECN */
> +#define VIRTIO_NET_F_GUEST_ACCECN 26	/* Guest can handle GSO of AccECN */
>  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
>  				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
>  #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
> +#define VIRTIO_NET_HDR_GSO_ACCECN	0x10	/* TCP AccECN segmentation */
> +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS	(VIRTIO_NET_HDR_GSO_ECN | \
> +					 VIRTIO_NET_HDR_GSO_ACCECN)
>  	__u8 gso_type;
>  	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
>  	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */


UAPI changes need to be added to the virtio spec.
Pls get this approved by the virtio TC.
Thanks!


> -- 
> 2.34.1


