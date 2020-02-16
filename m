Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA57D16042F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2020 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBPNm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Feb 2020 08:42:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53911 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPNmz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Feb 2020 08:42:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so14555107wmh.3
        for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2020 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=48n9jO4UaNqIvxx3QiffDGx3j4Sbkc7fJI5IamHifzQ=;
        b=WyXsUyAix84n4B+OeVFNG89yt6kbCDC99+uliNCnyuGOqsY9/BfWtfbG8UlGdWe6pH
         7hEzBjCXkkjc8If1cdv3gSu9EVuLErIfX8yaSm1m/aL1BVZPjV7uKtFxQSnOxt8L4PlZ
         BOppxhfCdCrp8rsoToDg4xb2ei+TwVjQJ8FtbZn8TKuzkaCREySa2+mIdpqLjAJP6y8V
         Rsn/kzjjfjh7pVRlX95Hjba22MaSOn+zZANE4GA/3IT/7Av9rIo1Pa+GZGQOj+4U6TQU
         7mb6ztgy/5ho6O4e6R7Db/0oLZRlkL850KIc4tlbV9faUZvlsWHSVDcArbb4GwiiR+nn
         ugVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=48n9jO4UaNqIvxx3QiffDGx3j4Sbkc7fJI5IamHifzQ=;
        b=pMxMjyHMuBjtWea4bQW23D+drTrzfESe46tYStsNgOVC0xC/FGtWY+wSATG+YyArUG
         3cwl1OGc8Mxcfh2UVRkAyQ2hKkJcjPyZg3n7oLaHKWCWi+NhhXJjZU5VIU0S9EyEv/xR
         tBrMXCIh9NbFrBE4AdZkjaCl13SNSeokis37kUxAFY0trbN9t/BVIpqlnVb2UYb12b98
         c8fUGxNkfxzKtNyj05NZq1gPjjShyAPjRDInG2lheU2kDt0xZd6A43QB3QPJfLdlqoQw
         fiz7+c/2TXJXM2DUH1G4Q+elBCAuVyKu4XSh5872SSw3FT9dYE4F5huAGIAHnI0qPsg3
         8B8g==
X-Gm-Message-State: APjAAAXMD5osf54t4zjsGu8wWEix0teTBAFWWZkM/pkSbGy3+U5b0DVi
        xiX55oyY1d0nV9VsjW3MCfM=
X-Google-Smtp-Source: APXvYqwsfowIqvYfX1Ds8kdRLyCqjNV7w9ov+1+TJOgOBRO7F4ljOMR0LY4vqBVUKvbE+vAfs6q+og==
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr16027550wmc.126.1581860573238;
        Sun, 16 Feb 2020 05:42:53 -0800 (PST)
Received: from kheib-workstation (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id j5sm15936951wrb.33.2020.02.16.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:42:52 -0800 (PST)
Date:   Sun, 16 Feb 2020 15:42:49 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATH for-next] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200216134249.GA7456@kheib-workstation>
References: <20200213130701.11589-1-kamalheib1@gmail.com>
 <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9565E197.68A7B59D-ON0025850D.0049D122-0025850D.004CDC1C@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 01:59:30PM +0000, Bernard Metzler wrote:
> -----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----
> 
> >To: linux-rdma@vger.kernel.org
> >From: "Kamal Heib" <kamalheib1@gmail.com>
> >Date: 02/13/2020 02:07PM
> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Doug Ledford"
> ><dledford@redhat.com>, "Bernard Metzler" <bmt@zurich.ibm.com>, "Kamal
> >Heib" <kamalheib1@gmail.com>
> >Subject: [EXTERNAL] [PATH for-next] RDMA/siw: Fix setting
> >active_{speed, width} attributes
> >
> >Make sure to set the active_{speed, width} attributes to avoid
> >reporting
> >the same values regardless of the underlying device.
> >
> >Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> >Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >---
> > drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >index 73485d0da907..b1aaec912edb 100644
> >--- a/drivers/infiniband/sw/siw/siw_verbs.c
> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev,
> >u8 port,
> > 		   struct ib_port_attr *attr)
> > {
> > 	struct siw_device *sdev = to_siw_dev(base_dev);
> >+	int rc;
> > 
> > 	memset(attr, 0, sizeof(*attr));
> > 
> >-	attr->active_speed = 2;
> >-	attr->active_width = 2;
> >+	rc = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> >+			 &attr->active_width);
> > 	attr->gid_tbl_len = 1;
> > 	attr->max_msg_sz = -1;
> > 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> >@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8
> >port,
> > 	 * attr->subnet_timeout = 0;
> > 	 * attr->init_type_repy = 0;
> > 	 */
> >-	return 0;
> >+	return rc;
> > }
> > 
> > int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
> >-- 
> >2.21.1
> >
> >
> Hi Kamal, 

Hi Bernard,

> Many thanks for looking after this! So there definitely seem to 
> be applications which are taking care of those values. So, good
> to get my obvious laziness fixed.
> 

Sure :)

> I tried your patch on a 40Gbs Ethernet link (Chelsio cxgb4 driver).
> Works in principle, but reported numbers are off. I am not saying
> I would get right numbers when using Chelsio HW iWarp (iw_cxgb4),
> but it's closer to reality (using ibv_devinfo <ibname> -vv)
> 
> iw_cxgb4 driver:
> ...
>    active_width:           4X (2)
>    active_speed:           25.0 Gbps (32)
> 
> siw driver with your patch:
> ...
>    active_width:           4X (2)
>    active_speed:           10.0 Gbps (8)
> 
> Any idea how we can improve that, maybe coming even
> close to reality (40Gbs)?

Could you please share the output of ethtool <if_name> for the underlying
net device that used for both iw_cxgb4 and siw?

> 
> Another remark: It has been siw folklore to name
> integer return values 'rv', and not 'rc'. I never
> liked 'return code'. It's a value in principle,
> sometimes it's interpreted as a code though, as in
> your case.

Sure, I'll fix it in v2.

> 
> Many thanks!
> Bernard.
>

Thanks,
Kamal
