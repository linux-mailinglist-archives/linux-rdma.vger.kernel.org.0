Return-Path: <linux-rdma+bounces-3471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4844C916533
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1F21F22851
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E514A4EB;
	Tue, 25 Jun 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiGBeVNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3FB136E28
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311060; cv=none; b=I3cJjOmJ8mg5Lah3O9hKJQ3XHcdFv0nz5YSSWqZVIelm2eCht6WpndfERPOE4zHL1NBU4ANTpNLUYb9nQQwWbTQePyjRCkKxCegBVXPDfdqmASBuGhDXxgVnO3S1xQwFmAgYhEZ/zKx7PW1DKlXNzVzxzFJWzoe6o6JvALwWCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311060; c=relaxed/simple;
	bh=JR/qDwFwlkXIJZghu8zx201/DRc5yzK2jHUrWR5u18s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNHvh3JXSAbQqjAG86L8YBN1VgEzrsimrq01aPH+sRGSm/tYqXUqT/Cg+bEeISmEhNBZu0c5R+/KrdqD7snvpSSMEqXWkkGGr8twPZu43Im1yR1XP7L2nglfgA+ElkBCRaMtzdNG3sVjzaT3pylBiFjnuVz3CruDKxZNsXd3nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiGBeVNp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719311057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JR/qDwFwlkXIJZghu8zx201/DRc5yzK2jHUrWR5u18s=;
	b=DiGBeVNpWv1i0xlm3rKO86XbTw+Mm7T/6X+gnRhT17nfjV/wzeRwomL0HV7oqQ1+0/tElH
	bkds+c5rNuH+siTCQKfBjDnA6/BrGMiN4Nyj3QQBlNJJgSaXOkkGy1pHF3bOmkXNms9seB
	iIqa+O8Vh6lpLcCwa0PZMEi8aT15Hqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-fZVhpXXkPbm-7wxDjLhf9A-1; Tue, 25 Jun 2024 06:24:15 -0400
X-MC-Unique: fZVhpXXkPbm-7wxDjLhf9A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-362a1e80424so571547f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 03:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311054; x=1719915854;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JR/qDwFwlkXIJZghu8zx201/DRc5yzK2jHUrWR5u18s=;
        b=NKp1Bwn4M+hbLOrElQQqdrF2v2YbJjAASdNKP8fH6jcmwKTLwKOpPrQwl0MpbF2sKR
         ZI8EF4mtg6CK0fX/NAan2LE2LNUitQynzp/d7AeBUFbneQlEOVzW7IorfrnNmcgnzZv9
         PEsekosehQ0RPOpsM0BMVjnyUwd3/kfFkR4RoNO1EzKk9zfQHE3KEAdvRzgbNRtxavIe
         LNFPlAGFlSLf2b2UqEq99JVjtMPR+OuoEW1McMnvqFFuf7pUd+U8C7xOnTJNyUeavfMw
         mLvEyE4nHUD+w9YPcpa3pGqZ5KEpbWqHqAJCEgIkFPKlRoOQ+GiT1cQZBYO86f9R/knb
         oSfw==
X-Forwarded-Encrypted: i=1; AJvYcCViwy6Uv3FoFosRgduB7pSmm0ahlEiImCOJlm0gaUej0qoAWFYsTZqNhq0ho92muNlSOa/GhnhLGK3vrN80NR2xsU7/ETr0zUYB9w==
X-Gm-Message-State: AOJu0YwqYWJJxX3a1sAlEauRWB6AhrDKqPstDQhHSM4Yqj2cI334U67E
	wyUnqeklx/fvS63ZqHr+I+2YpWfIrKkVQJ/XmTav0m89U/i3/2szMf8fn8k77LTboxPmd0GtUQ0
	AW2obsYoFUetq21CmOap4tXJ7eJrTxSMVi+5uwyMmqj+01T348RIDsVmaGJ0=
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd0c with SMTP id ffacd0b85a97d-366eb60be9cmr4976163f8f.3.1719311054698;
        Tue, 25 Jun 2024 03:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFGevlCkloEHTqSBSRezIkGXdcTB1lUzncXGf4ZXsiNyRjOLYu1nNT1wb+bRsvcdRCxDUwdA==
X-Received: by 2002:a05:6000:2a7:b0:366:eb60:bd0c with SMTP id ffacd0b85a97d-366eb60be9cmr4976145f8f.3.1719311054291;
        Tue, 25 Jun 2024 03:24:14 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e4dsm206415575e9.33.2024.06.25.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:24:13 -0700 (PDT)
Message-ID: <ac1789693e62aa47b527294fd402718306e43afd.camel@redhat.com>
Subject: Re: [PATCH 00/15] ethernet: Convert from tasklet to BH workqueue
From: Paolo Abeni <pabeni@redhat.com>
To: Allen Pais <allen.lkml@gmail.com>, kuba@kernel.org, Matthias Brugger
	 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>
Cc: jes@trained-monkey.org, davem@davemloft.net, edumazet@google.com, 
 kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
 naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
 cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
 stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, borisp@nvidia.com, 
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Tue, 25 Jun 2024 12:24:11 +0200
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 22:05 -0700, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>=20
> This patch converts a few drivers in drivers/ethernet/* from tasklet
> to BH workqueue. The next set will be sent out after the next -rc is
> out.
>=20
> This series is based on=20
> commit a6ec08beec9e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git=
/netdev/net")
>=20
> First version converting all the drivers can be found at:
> https://lore.kernel.org/all/20240507190111.16710
> -2-apais@linux.microsoft.com/

The above link was mangled.

I guess you will have to re-submit to cope at least with Andrew's
feedback, but it think it's better to wait a little longer for the next
version, to give the vendors more time to actually test this.

When you will re-submit you can retain the already collected ack.

Please include the target tree ('net-next') in the subj title and a
revision counter ('v3'). The whole subj should be:

[PATCH net-next v3 00/15] ethernet: Convert from tasklet to BH workqueue

Thanks,

Paolo





