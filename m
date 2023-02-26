Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC896A2FC2
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Feb 2023 14:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBZNQt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Feb 2023 08:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZNQs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Feb 2023 08:16:48 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2916113ED
        for <linux-rdma@vger.kernel.org>; Sun, 26 Feb 2023 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1677417406; x=1708953406;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=5ZAmb51STtiYorYxP+hZkJN6lXcQXoLUTuZsxRm/DVM=;
  b=aIgZreCvQDqmBlYY+uS4wrsD5d1GK7jhWYv5a9PR5bdlef8iyQ++XfTa
   2VJmilFytc2PpoyychgoTDeaF2KaTUG5k6QeJvJ6Kdx/2UpIpQnyiCIVd
   35MQwt+l1oua1zNoVIp1D8Bkqrlu/GO3OuxvkFLJ9zMBjc35hxsPdVLag
   g=;
X-IronPort-AV: E=Sophos;i="5.97,329,1669075200"; 
   d="scan'208";a="186599735"
Subject: Re: [PATCH] RDMA/efa: Add data polling capability feature bit
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 13:16:43 +0000
Received: from EX19D018EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com (Postfix) with ESMTPS id BB3AD40D49;
        Sun, 26 Feb 2023 13:16:42 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Sun, 26 Feb 2023 13:16:41 +0000
Received: from [192.168.74.118] (10.85.143.174) by
 EX19D045EUC003.ant.amazon.com (10.252.61.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Sun, 26 Feb 2023 13:16:38 +0000
Message-ID: <a938dbf7-192c-e7e4-cb79-dc8471c2484e@amazon.com>
Date:   Sun, 26 Feb 2023 15:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.1
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Margolin <mrgolin@amazon.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <matua@amazon.com>,
        Yehuda Yitschak <yehuday@amazon.com>
References: <20230219081328.10419-1-mrgolin@amazon.com>
 <Y/TS1hBcscBxmM6u@nvidia.com>
From:   "Nachum, Yonatan" <ynachum@amazon.com>
In-Reply-To: <Y/TS1hBcscBxmM6u@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.85.143.174]
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D045EUC003.ant.amazon.com (10.252.61.236)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> For UAPI changed you need to open PRs on rdma-core github before it
> can be reviewed.
> 
> Jason

Hey, thanks for the response.
We have a open PR on rdma-core: https://github.com/linux-rdma/rdma-core/pull/1312

Thanks, Yonatan.
