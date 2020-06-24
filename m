Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED220715E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbgFXKm6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 06:42:58 -0400
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:59985
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388770AbgFXKm5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 06:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOPy3dhQJ3aReKlaZQgPPucmaHtFU9zBcc5rGIrLhqWaBBDHn3Zp8NDulPszP2hatI/8WFNaQnFKwu9grRrUKolS0YVJET6PrbKOkkHylvS9K83AQdGx433yIZH3vR+ZpY1FcpZK9VdiSzH26Mbfkgsr2WwoajlnGZk42NBCpKRg1w/SblBEPhcZMDMWUezKgjELAcbOPjM3LH2fEJRIjtH4QnYpkhudmGqXGgTZ4N9rvNoNWK0JQuAy/vGb63DVX2JnIHXbojXKWHE7nKfKyPVMuoydnLDLymjlCSj9H/kC5lMIRJsQr5XwPteMtErOKfE24vtsEi+dd9e5/JFn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jomQSdPb1oYCRB7GimUVj+SjonhHvVOmi43MwskozI=;
 b=kh43ZJ4pMxdsb6kQZeyDHGNB8UmSuCuzjMavFWBxjb2CDNTZQ3PcwkVY3770r6Vr4YallCyYV7ireOzYXE4xIYrqgims3Y/st0JIcE+zvZkrHYFvd9UGZIcW2nvt6BhoZkA8KahF4M25nWICGpc9y4Y9X6arR1k351Ifk/NdlBkqKtak9ntxjMBv866oIbyB/AHeHmrmwNXBxmp6mXTnZme9RBlrWitEVZP25A3wbcvhdLEq64jQIJJESEkOJrO+pxcLCxHxSZ7vzH18QJ816iSN7gkKyyqoZZwAuKrvpmDXxouv2D3P9K4nuyQvVmVv3u/rxlGLwLmCiUd/RF+Q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jomQSdPb1oYCRB7GimUVj+SjonhHvVOmi43MwskozI=;
 b=OtXDRA6CYrx0ZjWCex2V3V0Mf+E1MIY9kd4PpqnpbT60flgOKklexBRzpv+QS1bc/OtRFWFKufKu9Bh1cedPegGJCrkJoelSCyWe4ZC6sHpzvL4VhJRtvirElIBVljPOLcDUiiXlk/fcv1asHx9/yv7Ro028ff7wX4N0CsamHbA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB5618.eurprd05.prod.outlook.com (2603:10a6:208:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 24 Jun
 2020 10:42:53 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 10:42:53 +0000
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com> <20200623181506.GC184720@unreal>
 <20200623184940.GN2874652@mellanox.com>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <d5206962-69ae-48e7-261b-485db71d2a41@mellanox.com>
Date:   Wed, 24 Jun 2020 13:42:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200623184940.GN2874652@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22)
 To AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.10] (93.173.18.107) by AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 10:42:52 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cdfca79-d392-4112-ec4b-08d8182b591d
X-MS-TrafficTypeDiagnostic: AM0PR05MB5618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5618B1DE254B01D76D3E1C52D3950@AM0PR05MB5618.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Gt+fJSxN9Qod3gJD1oOkXM/BUH3k/ZPDhORn5iNwao4hSyGkd3N9LiAt0YQsgcTFBo2U23oyH4b2rvuT92sw8kHj+6+FzNgBE/AdxpKb5xWqePpct/psLt4eWLmxSKrAPCoibagl5XaFXivjeKh0JaU8seQQtHTVDPmRE3pDZmAaui1UthzJpGn4cExswVmPSmQYcf2qrvXNVLMyPN6zWwe/j65pbbUNouvn2sfdc2hWh9EoY1Hb45hai9Ka67oO5wNvowIvrOjF88KMFArsgTyxk6XeLAQ+32QrmZ1cZSFLSMaO+Gyh5JE1g1ltfsqQg+jZ6aMmbW833c4fRPO8qkFlMzA9t7IBWIYIK/T1warMvQYmcMzgskfsyevssmF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8936002)(8676002)(86362001)(5660300002)(31686004)(2906002)(26005)(83380400001)(478600001)(110136005)(4326008)(53546011)(186003)(16526019)(6666004)(16576012)(52116002)(2616005)(956004)(66476007)(66556008)(36756003)(316002)(6486002)(66946007)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Seymh8ofbGVhE1mDDE6JJz2yHgJGc+zxFIuLO9L5z4h6ZkC4F42zF9/zvly6yfroHa+ImfRqKfLBPOyGRSg+Xdx571upePMk2pI79tuumeiaKWy0E0nKtpMyIUg+w2s33gG1wXpZouLmDd6Bg96szfeylA8AzfRzAK14UGJdnnxPvS8vzCZ2nVTGPSVpn721AVPmNvj146YUO6cwU0Fk/bRRZ3awz0KAv8kHqa2/gUge2nAtkFZEkL1zJw9ywqjJvym90Mi+ksx8k/nqqSRPPxsrJMpSipg+ws77WD/iants/WzhAdoncxls4G2AIiJrkvjlKpf2FittlNFJPc2WJpgIr+hAkJQ5ZOdizyHTb22/SwJ7124r0Iue6e25Yk6XEKjwhayc2qmgJwpBoG2dWgSsf/8RB/BglD3XkFlv/l43z5rw8EW84BvMBV0BrZWAYBCOjsqCwFDTjGeovO4GAHLylbBv5Rf9lAspz3ZVDby/5m2BLr0bA77O0jua7RQ6
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdfca79-d392-4112-ec4b-08d8182b591d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 10:42:53.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 234BN4IaAj+MSPTWZq1pv28gEB87KZItir2SYQB5sD0YovH6WvUwcVsSISzEG8gk2yTQCnH1JHcRc1/YyKfoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5618
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/23/2020 9:49 PM, Jason Gunthorpe wrote:
> On Tue, Jun 23, 2020 at 09:15:06PM +0300, Leon Romanovsky wrote:
>> On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
>>> On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>
>>>> Replace the mutex with read write semaphore and use xarray instead
>>>> of linked list for XRC target QPs. This will give faster XRC target
>>>> lookup. In addition, when QP is closed, don't insert it back to the
>>>> xarray if the destroy command failed.
>>>>
>>>> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>   drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
>>>>   include/rdma/ib_verbs.h         |  5 ++-
>>>>   2 files changed, 23 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>>>> index d66a0ad62077..1ccbe43e33cd 100644
>>>> +++ b/drivers/infiniband/core/verbs.c
>>>> @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>>>>   	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
>>>>   }
>>>>
>>>> -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
>>>> -{
>>>> -	mutex_lock(&xrcd->tgt_qp_mutex);
>>>> -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
>>>> -	mutex_unlock(&xrcd->tgt_qp_mutex);
>>>> -}
>>>> -
>>>>   static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
>>>>   				  void (*event_handler)(struct ib_event *, void *),
>>>>   				  void *qp_context)
>>>> @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
>>>>   	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
>>>>   		return ERR_PTR(-EINVAL);
>>>>
>>>> -	qp = ERR_PTR(-EINVAL);
>>>> -	mutex_lock(&xrcd->tgt_qp_mutex);
>>>> -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
>>>> -		if (real_qp->qp_num == qp_open_attr->qp_num) {
>>>> -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
>>>> -					  qp_open_attr->qp_context);
>>>> -			break;
>>>> -		}
>>>> +	down_read(&xrcd->tgt_qps_rwsem);
>>>> +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
>>>> +	if (!real_qp) {
>>> Don't we already have a xarray indexed against qp_num in res_track?
>>> Can we use it somehow?
>> We don't have restrack for XRC, we will need somehow manage QP-to-XRC
>> connection there.
> It is not xrc, this is just looking up a qp and checking if it is part
> of the xrcd
>
> Jason


It's the XRC target  QP and it is not tracked.

