Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5F161440
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBQOLx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Feb 2020 09:11:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34362 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgBQOLw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Feb 2020 09:11:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so7463997wme.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4rC0PcLeqkRSIsnWIso0bbv2PZ5iIUf6o2rzrea9ciA=;
        b=ULA+KjmircNsAoPslfw0tPl29D8CcA2Pb0DNnanfpVkwn393AYSZC0JV50Hj7e+VqB
         ekZflODH+whvDmD7hmncY/jnSkr1auFiB69kbQRaU1zZwJ9Ev2Xs/EvW2FDDcisgdx4R
         QNUiwtx2nhV2lTsEDFFhM7KYnn9LaF1wyzDFSQ0vY4SZA0hYmcrgzuSLc6W3jG6NOfSa
         ZbQlL3IBe0I+irE8lt/nD5IpJu3k50gZljso01mPje19o4lJnHrq8V8YZmW9MFTc4dhr
         M0cNN9OADhk61wbo3kiyM9RLFikSJJ/ufVF5PwAsQjUIhiXwVoah0Tc0ztW9yOTbjBli
         f3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rC0PcLeqkRSIsnWIso0bbv2PZ5iIUf6o2rzrea9ciA=;
        b=koetkA5ou5VxM7jAUM7Qsv06RWTIlCO0zTeLuSwVWo/yr104zSy38nXQYS61ls9mH4
         w6JFeNleozfrHbQn/m5FhNUB6bP6iLh8XncBlGgynU+yd7XVAqSO8Q8xN4k44YsHyjkS
         zoLmf+bYwW8yjL2VPpW+sEZVaox9uj2vpcKQde4JCqzMLumjQypJFTzLA0smXLOCsm/w
         O95i7mNNLAl1afRx5cC6zTxHtqZLD7utjnQJREzmcQdI5Jsm5EziQHzcj2NBw1Oewsno
         UW71ferOwmsy0qm8ZJKFaI9TcPsGvDbDPhoyRxQoOsbTlEja5kOfeZUdMe9S+e+3gabE
         Y2dw==
X-Gm-Message-State: APjAAAUQYE8o9FtlUQR491+1TTW7omGzBUMfqA/pnNZ7Z1yLr2/hDGBH
        P0UUzzOivIrAL7ioIRQLGwEVxnTFKTY=
X-Google-Smtp-Source: APXvYqwO02d9yJo6v0J0QSbGSRrq0T5SxFoaegWcy9GeR4CBrSogM9o6fh4TtZyWuBmdT+d33NS+fg==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr22319931wmd.171.1581948710960;
        Mon, 17 Feb 2020 06:11:50 -0800 (PST)
Received: from kheib-workstation (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id z4sm1135836wrt.47.2020.02.17.06.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:11:49 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:11:46 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATH for-next] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200217141146.GA1908@kheib-workstation>
References: <20200216134249.GA7456@kheib-workstation>
 <20200213130701.11589-1-kamalheib1@gmail.com>
 <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
 <OF10DED8FF.9794F86F-ON00258511.003822AA-00258511.003827A8@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF10DED8FF.9794F86F-ON00258511.003822AA-00258511.003827A8@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 17, 2020 at 10:13:21AM +0000, Bernard Metzler wrote:
> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >Date: 02/16/2020 02:43PM
> >Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
> >"Doug Ledford" <dledford@redhat.com>
> >Subject: [EXTERNAL] Re: [PATH for-next] RDMA/siw: Fix setting
> >active_{speed, width} attributes
> >
> >On Thu, Feb 13, 2020 at 01:59:30PM +0000, Bernard Metzler wrote:
> >> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> >> 
> >> >To: linux-rdma@vger.kernel.org
> >> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >> >Date: 02/13/2020 02:07PM
> >> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
> >> ><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>,
> >"Kamal
> >> >Heib" <kamalheib1@gmail.com>
> >> >Subject: [EXTERNAL] [PATH for-next] RDMA/siw: Fix setting
> >> >active_{speed, width} attributes
> >> >
> >> >Make sure to set the active_{speed, width} attributes to avoid
> >> >reporting
> >> >the same values regardless of the underlying device.
> >> >
> >> >Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> >> >Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >> >---
> >> > drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> >> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >> >
> >> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >index 73485d0da907..b1aaec912edb 100644
> >> >--- a/drivers/infiniband/sw/siw/siw_verbs.c
> >> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >> >@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device
> >*base_dev,
> >> >u8 port,
> >> > 		   struct ib_port_attr *attr)
> >> > {
> >> > 	struct siw_device *sdev = to_siw_dev(base_dev);
> >> >+	int rc;
> >> > 
> >> > 	memset(attr, 0, sizeof(*attr));
> >> > 
> >> >-	attr->active_speed = 2;
> >> >-	attr->active_width = 2;
> >> >+	rc = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> >> >+			 &attr->active_width);
> >> > 	attr->gid_tbl_len = 1;
> >> > 	attr->max_msg_sz = -1;
> >> > 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> >> >@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev,
> >u8
> >> >port,
> >> > 	 * attr->subnet_timeout = 0;
> >> > 	 * attr->init_type_repy = 0;
> >> > 	 */
> >> >-	return 0;
> >> >+	return rc;
> >> > }
> >> > 
> >> > int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
> >> >-- 
> >> >2.21.1
> >> >
> >> >
> >> Hi Kamal, 
> >
> >Hi Bernard,
> >
> >> Many thanks for looking after this! So there definitely seem to 
> >> be applications which are taking care of those values. So, good
> >> to get my obvious laziness fixed.
> >> 
> >
> >Sure :)
> >
> >> I tried your patch on a 40Gbs Ethernet link (Chelsio cxgb4 driver).
> >> Works in principle, but reported numbers are off. I am not saying
> >> I would get right numbers when using Chelsio HW iWarp (iw_cxgb4),
> >> but it's closer to reality (using ibv_devinfo <ibname> -vv)
> >> 
> >> iw_cxgb4 driver:
> >> ...
> >>    active_width:           4X (2)
> >>    active_speed:           25.0 Gbps (32)
> >> 
> >> siw driver with your patch:
> >> ...
> >>    active_width:           4X (2)
> >>    active_speed:           10.0 Gbps (8)
> >> 
> >> Any idea how we can improve that, maybe coming even
> >> close to reality (40Gbs)?
> >
> >Could you please share the output of ethtool <if_name> for the
> >underlying
> >net device that used for both iw_cxgb4 and siw?
> >
> H Kamal,
> 
> Sure! Speed looks correct, and its also what I get
> at maximum:
> 
> [bmt@spoke ~]$ ethtool enp1s0f4 
> Settings for enp1s0f4:
>         Supported ports: [ FIBRE ]
>         Supported link modes:   40000baseSR4/Full 
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Supported FEC modes: None
>         Advertised link modes:  40000baseSR4/Full 
>         Advertised pause frame use: Symmetric
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: None
>         Link partner advertised link modes:  40000baseSR4/Full 
>         Link partner advertised pause frame use: Symmetric
>         Link partner advertised auto-negotiation: Yes
>         Link partner advertised FEC modes: None
>         Speed: 40000Mb/s
>         Duplex: Full
>         Port: Direct Attach Copper
>         PHYAD: 255
>         Transceiver: internal
>         Auto-negotiation: on
> Cannot get wake-on-lan settings: Operation not permitted
>         Current message level: 0x000000ff (255)
>                                drv probe link timer ifdown ifup rx_err tx_err
>         Link detected: yes
>

Hi Bernard,

Well, this is the expected value for 40GbE, Because the reported value
is 4X aggregation of FDR10. For more info please the table of speeds
under [1].

[1] - https://en.wikipedia.org/wiki/InfiniBand

Thanks,
Kamal
