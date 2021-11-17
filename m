Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFDF45492D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhKQOxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhKQOx3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 09:53:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A13C061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 06:50:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so5218354wrb.6
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gG3Xq3XTPIcBKFYF9WdHtAqLKyYO4QDxI0LN2xX9It0=;
        b=d/TZvDEVvdv4BpVWPBaCiG66aojbc/Bio/QoJfC+TH5NMhYbG53TNiAPOgLv6Q6IgL
         dYz5TBgGxbdebbUaaYi2Mr3jXnxA9eOzt7AM2iGIIBnxNTNtczMnHDIFlpS3Ln2TUVYH
         UPQGq25hP+gZhHAh0ISYumWNy1wsVC9EZ1r0E52Mt1PKHpioM3QMA8crShoo+wQ7ikAZ
         T2S4BV2BJdsAavuod5CWmvm1vx5PbfQusM0vXKeJ7yyKI02SU0WZdo77ZGt/TJx37aaZ
         IKhGmtGY8+oNsCYNeXTkqlrqjfQBJXRUbXgfKkxSu8lJwjMksafbmSNCRWcH7cr3jqub
         pXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gG3Xq3XTPIcBKFYF9WdHtAqLKyYO4QDxI0LN2xX9It0=;
        b=nz9wX+rifB5UV/f5/ud0l+HKuoeB+4SvghOFvTaq7+WR1bTkwPRWsZR//Wgu6U9tMn
         uWZp215iyNYIPauePN5+iNJSPtyDD+lEDUB1+dZrrQccZ+LyTeQh6hy70+JCY8KlXbEk
         4s9buMFXCjR+eScpwaRBZN0vuwsMjoUMgm+j6XoIqx99wvGO3sctWBOyGZM/+1iZtfFT
         X9xMrYH7aZxzjsiPT2KAWVocPYjG1SCzpnHK82VYcRNFiyiI3Y3OcYuhmxzxoW6ERgxZ
         DBmg80cyiqlO7QB4jViuqojnxQGymd3CFW2BZFJ03f4x8mwvhuPGbbiPjqEgxh6QuCx5
         0L2g==
X-Gm-Message-State: AOAM533QtfShL3icRahzxhffKFfYhTbgMWeyaNRNB1QRygnZtSAEeBiM
        +Dqds+eMP0IJTw62yhFikRQnfLGqJNXN3Q==
X-Google-Smtp-Source: ABdhPJwZVs0jglrF2gqX1lVVHyO24nDj9ZPkgaDL6ChkvC7fuWePq+rZ71/cWfMiOmz4gbkv9Zi3Nw==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr20462217wrx.155.1637160629676;
        Wed, 17 Nov 2021 06:50:29 -0800 (PST)
Received: from fedora ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id m36sm7167590wms.25.2021.11.17.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:50:29 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:50:26 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/hns: Validate the pkey index
Message-ID: <YZUWst63NnrfbxaK@fedora>
References: <20211117111009.119268-1-kamalheib1@gmail.com>
 <26672F24-3F75-4F41-AD6C-08AE482DE55F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26672F24-3F75-4F41-AD6C-08AE482DE55F@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 11:45:49AM +0000, Haakon Bugge wrote:
> 
> 
> > On 17 Nov 2021, at 12:10, Kamal Heib <kamalheib1@gmail.com> wrote:
> > 
> > Before query pkey, make sure that the quered index is valid.
> 
> queried index ?
> 
> Thxs, Håkon
> 

My bad, I'll fix it in v2.

Thanks,
Kamal

> > 
> > Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> > drivers/infiniband/hw/hns/hns_roce_main.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> > index 4194b626f3c6..8233bec053ee 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> > @@ -270,6 +270,9 @@ static enum rdma_link_layer hns_roce_get_link_layer(struct ib_device *device,
> > static int hns_roce_query_pkey(struct ib_device *ib_dev, u32 port, u16 index,
> > 			       u16 *pkey)
> > {
> > +	if (index > 0)
> > +		return -EINVAL;
> > +
> > 	*pkey = PKEY_ID;
> > 
> > 	return 0;
> > -- 
> > 2.31.1
> > 
> 
