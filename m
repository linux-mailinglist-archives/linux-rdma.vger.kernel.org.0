Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2A7D6A90
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjJYL45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbjJYL44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 07:56:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2101189
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 04:56:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084095722aso45385435e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235010; x=1698839810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXnFAA6nJ3vdBmdvOHO5kEMio4De3SXfO+uLDP8B2BY=;
        b=J1Hc8BV9H7FwizeE5RpHJodP3Uu+YIiIxcFe3vxWNGL48de+Sf7JSTYId/LJkqY8wS
         DS3j0JecxTS1ryFCL3dPR06L83mPlfrRaxLFDVvo3X/JPgGhumL5rL4EWkEaiH2JOUeO
         owGdRVrnjZgSUSdNVeSfgULECbo0fP19BzPF/dklJ+bct1GBJB/am1jdYpwRd+TYaTiR
         M7pF68UdiQlaV+sDWz1NLqUYKXvq7ME/smtCSjuNSsowne+fqy8l6pLe9ijWtT2G2vPW
         hyniIwGnhhgf+PVJpBXKlyKgjuWwTbqWPhWQtwsSMGXKWiL/xeojB4LKCOZDKtaF3xlv
         neQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235010; x=1698839810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXnFAA6nJ3vdBmdvOHO5kEMio4De3SXfO+uLDP8B2BY=;
        b=w7YVBgK6tzp3p8uWr1hhXl/FeGJWtSE+u6OMBcVZG4lEU6doilsmmJJs12apYrX6cQ
         6gvtYaTQSuC3PWhUoqGqW42/aAQj+ndXzv2uclLB6Monyu+NbLBaZVC3bmGGaTkXJBsn
         5u8w5g3cHO4vGKuOXPW12y0aPslfB5XdsUJ504nz5QKdBJkOV9s28V+ThNZHdkq+QdEd
         FyQIZg9lxoaa3U5Ik+CmBCA/pDifYbhSojw4GeqTDcaLJSHsAhuf3jOLsa1SsaQ7VSjz
         ZTt7Dz7Sunhtn68wtuKdzsAElinzcIFIzwyHb5IXOi2v3kV5Unn+IkemT8vceHrbu/Ti
         v1Ag==
X-Gm-Message-State: AOJu0Ywlpk07ChP+uXdKZ8iB1hgXIu6srcBeh7Qoa2QfMiNq43rZm5cs
        PJZVpxZsdhmSjUo2AafUWlNEfw==
X-Google-Smtp-Source: AGHT+IE0IdmtBUuHfNComqoPSGDOIgvn0B3539P+0Xt5wwjTypFL+viLK6nRNFlxkdBP6WPCG63+Gw==
X-Received: by 2002:a05:600c:9a5:b0:406:599f:f934 with SMTP id w37-20020a05600c09a500b00406599ff934mr13028034wmp.12.1698235010338;
        Wed, 25 Oct 2023 04:56:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fee6e170f9sm14582330wms.45.2023.10.25.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:56:50 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:56:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] rdma/siw: connection management
Message-ID: <e2ef5057-fe85-4fa4-bcbc-2e7c34680fb1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bernard Metzler,

The patch 6c52fdc244b5: "rdma/siw: connection management" from Jun
20, 2019 (linux-next), leads to the following Smatch static checker
warning:

	drivers/infiniband/sw/siw/siw_cm.c:1560 siw_accept()
	error: double free of 'cep->mpa.pdata'

drivers/infiniband/sw/siw/siw_cm.c
    1545 int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
    1546 {
    1547         struct siw_device *sdev = to_siw_dev(id->device);
    1548         struct siw_cep *cep = (struct siw_cep *)id->provider_data;
    1549         struct siw_qp *qp;
    1550         struct siw_qp_attrs qp_attrs;
    1551         int rv, max_priv_data = MPA_MAX_PRIVDATA;
    1552         bool wait_for_peer_rts = false;
    1553 
    1554         siw_cep_set_inuse(cep);
    1555         siw_cep_put(cep);
                 ^^^^^^^^^^^^^^^^^

This potentially calls __siw_cep_dealloc() which frees cep->mpa.pdata.

    1556 
    1557         /* Free lingering inbound private data */
    1558         if (cep->mpa.hdr.params.pd_len) {
    1559                 cep->mpa.hdr.params.pd_len = 0;
--> 1560                 kfree(cep->mpa.pdata);
                               ^^^^^^^^^^^^^^
Double free?

    1561                 cep->mpa.pdata = NULL;
    1562         }
    1563         siw_cancel_mpatimer(cep);

See also:
drivers/infiniband/hw/erdma/erdma_cm.c:1141 erdma_accept() error: double free of 'cep->mpa.pdata'

regards,
dan carpenter
