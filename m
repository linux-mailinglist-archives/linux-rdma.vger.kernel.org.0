Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7237D7058
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJYPCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjJYPCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 11:02:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F76B0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 08:02:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5629fdbf8so76778441fa.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698246137; x=1698850937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddJmjdlDS6zCBRcF5EN2lOWH8Kdan9QwRQ/fBcPvi5Y=;
        b=KsnA5DAf9HjO6Ac3e68fSJE28iMJ4Pc2DdS/4QKwbS2FeEhIXqDWhYej7xgBhNfP0G
         qttPyD4qnJqREki8kI2gAWqa4QXDlP2y4nq2BRw2zQTfjpmmw5A3Jn7mD/fiV73U1f8/
         kzi1W3+o9PKI4wU3YbAKbWE4HOO2gF+2cgXEIx68ubVc9fnnlofJyJ4XV1lOCdyq27mP
         F8pCMPy/w4S1aO05IplqaD0cmoVOyIuAy05hZxxs6e+0KpAj2fR22RXTUsPFrQtxEt/a
         hxrEpkoK8gtBy51eepwiVtryhovIdqagVzTXOqfjLywDhfpC7afzDAOnpViLvxtYkvRE
         jFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246137; x=1698850937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddJmjdlDS6zCBRcF5EN2lOWH8Kdan9QwRQ/fBcPvi5Y=;
        b=Wd6WSOymVUgkUtcL6I4AEf6+SghzET71pFOHXDTt02N5ZgSTIUDsQvMEfaQ7UtTOd5
         1op+V4gKyraRa8cjND5hccmsECHpERms1iPDEPInygpSPedgQAY/fswRVIC6qk+KRekU
         tPl9+V0Qu+vuanlpV0VcRktLR27sv+IWa/Hy7j22c8fp74DzTDvZu69gP7cd1LcgiIrR
         4g/cbUVtFYlQBdHtwXKJAvIwgY/a0SQZGoQQHbuOdkKtDJJSrERhtlIX0gS8UskOB7xi
         5tqodF49cG3ZcjWY8UVYDPuSW8trWhmkO4YktWAb1AeiLB/45Agc/mk25UM7cjr25enF
         X6NA==
X-Gm-Message-State: AOJu0YyrufCDtfwHyQ4DqKt82wv1GOtwEhaTzSqUTbO44djj2bwPzwmq
        z3/hxMNdF7C0preIollEWx+bJCWinIKlxoAPL1Q=
X-Google-Smtp-Source: AGHT+IE6ZoTUsyf8ghUuEx6eBLDTqz2pf7wW00dNvNHlYqFg2Oqu6b1SDfovnieqjkL6njAETxBrew==
X-Received: by 2002:a2e:9c06:0:b0:2c2:8f22:d9c2 with SMTP id s6-20020a2e9c06000000b002c28f22d9c2mr12419951lji.22.1698246137216;
        Wed, 25 Oct 2023 08:02:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040651505684sm12575wmo.29.2023.10.25.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:02:16 -0700 (PDT)
Date:   Wed, 25 Oct 2023 18:02:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] rdma/siw: connection management
Message-ID: <a234a40c-13d8-4b1f-98a0-2f1db7a1dff2@kadam.mountain>
References: <e2ef5057-fe85-4fa4-bcbc-2e7c34680fb1@moroto.mountain>
 <SN7PR15MB5755E7EC735931F3EA1DAD2699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR15MB5755E7EC735931F3EA1DAD2699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 25, 2023 at 02:31:08PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Wednesday, October 25, 2023 1:57 PM
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: linux-rdma@vger.kernel.org
> > Subject: [EXTERNAL] [bug report] rdma/siw: connection management
> > 
> > Hello Bernard Metzler,
> > 
> > The patch 6c52fdc244b5: "rdma/siw: connection management" from Jun
> > 20, 2019 (linux-next), leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/infiniband/sw/siw/siw_cm.c:1560 siw_accept()
> > 	error: double free of 'cep->mpa.pdata'
> > 
> > drivers/infiniband/sw/siw/siw_cm.c
> >     1545 int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param
> > *params)
> >     1546 {
> >     1547         struct siw_device *sdev = to_siw_dev(id->device);
> >     1548         struct siw_cep *cep = (struct siw_cep *)id->provider_data;
> >     1549         struct siw_qp *qp;
> >     1550         struct siw_qp_attrs qp_attrs;
> >     1551         int rv, max_priv_data = MPA_MAX_PRIVDATA;
> >     1552         bool wait_for_peer_rts = false;
> >     1553
> >     1554         siw_cep_set_inuse(cep);
> >     1555         siw_cep_put(cep);
> >                  ^^^^^^^^^^^^^^^^^
> > 
> > This potentially calls __siw_cep_dealloc() which frees cep->mpa.pdata.
> > 
> >     1556
> >     1557         /* Free lingering inbound private data */
> >     1558         if (cep->mpa.hdr.params.pd_len) {
> >     1559                 cep->mpa.hdr.params.pd_len = 0;
> > --> 1560                 kfree(cep->mpa.pdata);
> >                                ^^^^^^^^^^^^^^
> > Double free?
> > 
> >     1561                 cep->mpa.pdata = NULL;
> >     1562         }
> >     1563         siw_cancel_mpatimer(cep);
> > 
> > See also:
> > drivers/infiniband/hw/erdma/erdma_cm.c:1141 erdma_accept() error: double
> > free of 'cep->mpa.pdata'
> > 
> > regards,
> > dan carpenter
> 
> Thanks Dan.
> siw_cep_put() only calls kfree() on cep->mpa.pdata
> if cep was on its last reference. It then frees cep as well and
> no further reference to cep is allowed. This cannot be the case here.
> 

Thanks!

> To satisfy Smatch, without changing functionality we can
> reorder and first explicitly free any mpa.pdata and put it NULL
> before calling siw_cep_put(). I don't like it though, because
> it just satisfies Smatch but sacrifies readability.

Yeah, don't do that.  This Smatch warning is not finished or published
yet.  The rule is never write code just to make the checker happy.

I started to write a kref_put() dummy function for when you know that
you are not dropping the last reference.  I need to dust that off an get
it merged.  That might not be a bad option.

But either way, when this check is published people can just search lore
for the warning and find this conversation if they have any questions.

regards,
dan carpenter
