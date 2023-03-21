Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E26C2C39
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 09:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCUIX2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCUIXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 04:23:10 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011112F041
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679386990; x=1710922990;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=61RpPe0tblgxu9e6mR2wEDjfS6BXKFFhfBoD3yAlGwo=;
  b=v0s2wra5WjZ8nl4M6oTQyOAaSAFu9wbSHvSBvQxFwfA6sgBq6+t3rHxF
   SL7yhZ35K0C4kskSQAcqrgaDizFM0LjJ919VpnGb6ss5uSNwy4UNdMYdC
   EshS2tZwWTntcvyvToT0Unppn1K9A2izPR0FFCnAlrG3wnBKpYXIdDu9I
   w=;
X-IronPort-AV: E=Sophos;i="5.98,278,1673913600"; 
   d="scan'208";a="311457765"
Subject: Re: [PATCH] RDMA/efa: Add data polling capability feature bit
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:23:05 +0000
Received: from EX19D002EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 91B0A450ED;
        Tue, 21 Mar 2023 08:23:03 +0000 (UTC)
Received: from EX19D045EUC003.ant.amazon.com (10.252.61.236) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Tue, 21 Mar 2023 08:23:02 +0000
Received: from [192.168.17.188] (10.1.212.15) by EX19D045EUC003.ant.amazon.com
 (10.252.61.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24; Tue, 21 Mar 2023
 08:22:59 +0000
Message-ID: <b01845ab-1de7-4311-b1ef-1f254ccfaa41@amazon.com>
Date:   Tue, 21 Mar 2023 10:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To:     Michael Margolin <mrgolin@amazon.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>
References: <20230219081328.10419-1-mrgolin@amazon.com>
 <d0cf93b8-427f-7f95-1863-a4c370919cd5@linux.dev>
From:   "Nachum, Yonatan" <ynachum@amazon.com>
In-Reply-To: <d0cf93b8-427f-7f95-1863-a4c370919cd5@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.212.15]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
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

Hello,
Kind reminder for this patch.

Thank you.
