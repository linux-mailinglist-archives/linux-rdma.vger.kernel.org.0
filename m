Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1774C9119
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiCARIE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiCARH4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 12:07:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56465D6
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 09:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNP7YbhUNbaLmFuP0N9dx0XiEk5BuJm5F1hdM9exfWYX11bh1IMOvheyHsrANKVaSvov86TvTgiIFL+LP8ktYKCfTmGNeyOpQjB7c4j4BFdAMsaBK6L8DwG4HRsjSiC3tRXKEqYD/lD91u2UGzXZg9XqbR0DJpbg1dbxjCdcMgueIBEkXxDAN8LVFqmLsycAL3zFPNgA76fPRqFSmo6e1fly+iPym3Ktgp5vvZ67dc53mVemK4eGvYsYRedZAgFjgJphhg6O8gkB/9EjUBHnfXtzkfZGqARkRuqySnUay/DF5u79lGCP6rIwmwrkiDQN48JzJPrhtb32GwGIgO12Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSrh+u6Yk6beO342S35QUBtdPri8fxDOIHgMigHhst0=;
 b=h5/iPtS8LEo9BLJnZqTGY4pAHxdMIzHH+cixxPox36031JZQ6DX3jA9T8o5hfNvwD0N5pRDo51Pg7exS0tfzcA9fpEhqSznMvjWtNtd742DchD5tcs/3/zpJd2Dvzncv0M8YOED8TI7zAYr8BNYH4FNFg7Ny/QqijYXO7lmGR1I0tedx7qPFplyhybldX5UX1Zcb1dQp2pgn4mw+T6QFLmusmMZdN/lzpNp+Eaq+V7pbOEmml2wUmzmKKL1oayLkeVA7eRjkf9t2Qiqy91Cpg/Q3SRKODkpZbAO+oUX6h1dO/yuvzkjRb7VOzunnHjXDoVNDXJMzVtYLDhRLen9M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSrh+u6Yk6beO342S35QUBtdPri8fxDOIHgMigHhst0=;
 b=BtBaB4c3FIgey4pDuGQj0fVG0eiehLSRsNSx2hlDSWUv0mtOjGkFz7i28b5sp9cnVD0eIz7bR2hyNp78k+pvFpg0foKTG8tsxEMrwFz7+OdOuWiEnvFC5acxpF46skKde/41vI3MFCfYbXqZM7mWjp6bugGG9uvYYldeI1FbPZcixbjkN9zPaHa1Rx8kftjswr86XHx2RnXk/ci4VUCAm5tPqVnpdkQedqSzVLuHrQ6wzJpAK8kL0sIb6qBWVfKr1V1bhCLkxQft8nZNBst+DwGjlX9ZXm1S6KaZfMuyvHlzKMRV7OJ8lxIeAx7lNlkAqOs+5np20mwp7toSm4L26Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 SN6PR01MB4159.prod.exchangelabs.com (2603:10b6:805:ad::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Tue, 1 Mar 2022 17:06:08 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:06:08 +0000
Message-ID: <bf1ae61b-b728-fa57-d5b0-9dfb7a19bbf9@cornelisnetworks.com>
Date:   Tue, 1 Mar 2022 12:06:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH for-rc] IB/hfi1: Allow larger MTU without AIP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <42673e10-e828-fd6c-b098-2638cac6bea9@cornelisnetworks.com>
 <20220301165924.GG6468@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220301165924.GG6468@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0330.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::35) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48019ba8-2ee5-4c27-c029-08d9fba5c768
X-MS-TrafficTypeDiagnostic: SN6PR01MB4159:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB415947EE903C3F267DCCB404F4029@SN6PR01MB4159.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdpiPC8ox3bdbNU070xIGpAT+R2XLZw8ZDXMu2fmx9E3Edr/93D0J+FE2EtgnawGGjfsq/qZ9U0XJepmxG9ZILM2kxnoxfzr0BY431OlaJvV1l15Qa+5wWHIGhgOR530wkW50jCztxAWqBiUaYvY51QYMNLXQ9cRG9x7nJ0kwc0l4wJmRGADxwmDBLXN5dtA7ZCuTIDbVaP6f2xBhMiq6vkFNn/RkPNlEvYJPFvYxf3YDUrFdbPVx+S3ciKStHnyWtWH36aZgSukTQqxB6iPh7uN0zAdaK6t1rHfdd3eZbT31hbdZELYw+HN4g2UrxvYC5ROiOOP71eTQ97GiH2KZ4GHBfbebpRatZ6E8miJXdNy9E9gJcgQMA5zK/7gn5bo2bMq1hueP47LOGxXhnXOJ6gkU3vw//ldzwgJvbugOW+GbFFlkDYdOpdYQFKO/PN6tVZkARN9lfrH5bDa75csZ9lS1IBG1oHbG3zLpSHp8iPXv9GSh4C4cVFS3rWhXnq1Z1hiK2wKFj8G3zTyZKoTwU9MODt/lE/BzF2GljAPkiaJE92ekxrbxA+H8eOIgR3e5WWw7soQKn45oeAyV9r3+04rsAmRN5IdNGRDOCNyNa0Ut7qsIVMkk64o9ByFdPbQBTf5J9zV4gU8aqQdwgBP7khjzwhz1wHDcjHFhaFy0LSPo4NJWo7eHycsIykzCmtiseFxiSeZlIzap+bqT/6MM6b/Y50gHd9ZNsqEr7hj0Mpk3tf8uLhbJ67H2NPjYGX4RaDHCBlQle6tlSeu6nGvwQnwknWz0fwxlCTP03WtzPUT1ZTF6yiNWinGZBMlR9Mh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(396003)(39840400004)(366004)(136003)(376002)(8936002)(6512007)(38350700002)(83380400001)(4326008)(66476007)(66556008)(38100700002)(66946007)(2906002)(86362001)(31696002)(5660300002)(2616005)(26005)(31686004)(186003)(44832011)(6666004)(8676002)(36756003)(6486002)(966005)(508600001)(316002)(6916009)(6506007)(52116002)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXluQVVhejR2UGhwa083ODFiZm5pOFRCK0Q1eHJ2TFZrcFZYYUV5R3RKbnFZ?=
 =?utf-8?B?dXNxeW5tZHRvcWc4aGd2cVVvclRYTU1CTVAzOFRvSkdhVnJucTBlelVOZFNk?=
 =?utf-8?B?dTF0NWpsMEcrY240dmZzQ3JhRjJqR1NpR2tTTHZ5UWxNNm9YOG1TQ1Z1S0w5?=
 =?utf-8?B?b2xzUjgyajRvMGMrL0VVWk84OE5QUlhTYUZ0Z3JyTXpjTjA1a0V1MTVSbHBj?=
 =?utf-8?B?NDJTeXJUQUhuckxNVElrWVV6YzMxRlZjYTJLTkNMKzFiSS81KzlsYVpVSGk5?=
 =?utf-8?B?ajlWMnFsV0w5NEdyU3dZT2ZsVE5PV0dvWmd5VjVZRVdDdklFbWJYSzVCdnVB?=
 =?utf-8?B?M0QzTTljdVZpUkNMR29MZzljcnh3cFB4ejdOODAwMVE2Z2VSOEVYWXVnYzJD?=
 =?utf-8?B?V3NRTXRpQkNXaTkzMzBTc0ZwM0o5TGkvekpENFRZUUJrd2ZzdkdvWHpMK3JF?=
 =?utf-8?B?azgyZU9RUnBmeUZlbzdlUldaOERYU2ZsK2hyd1pSc2lES05qeXB5MWVaRS8v?=
 =?utf-8?B?T3JIUmZBUWxqNUE2N3g4Z0NIcWFCcjRURXRvdnVNZjNGTmVTdmpMdmFad1ZV?=
 =?utf-8?B?cGZhaUZFandTYjZ6aFVFOWFXT2dtbnBYZWxBTFpUVjd6Tk8rVkFXVjJ4UkFR?=
 =?utf-8?B?T0hBYkZEVXgzek5aTkI3cmFLbmNNbXRuZ3VJOThHL0NrazJKN2pVUmRKSVJM?=
 =?utf-8?B?N2ttSy9JVDY5cHNSNEN0V2R5ZnJma2xSRFJZK2RRL21POGhRRno2MDd1VEt0?=
 =?utf-8?B?M0ZPbTN3d3NBdE02TkdCRFhKcTV4YldHNHE4amgwQlZRNklldlk0UkU1TG9m?=
 =?utf-8?B?RGpsQm1ndXdxdDFEelJaYWJaVEM1Q1hiOTFyUmw5UVoySS9uTzdIRGFhaUlG?=
 =?utf-8?B?K1g0TDVlNXl6VDFpZk9CK2YyWFlUamFmMnNXNWJGbXpQRlE3d0tyd0t6VFFQ?=
 =?utf-8?B?eDR4T3hPZXNESldRZGdJUFFQTkhIeTRTQ0NNSW8yQjJBdENvOU5rTUx4ZUNH?=
 =?utf-8?B?cUxhZ1lXRm9wTFBJZ2FJSGRYMnRRbU84MWZTNStteUtaTjhTUVF3KzVuSlM2?=
 =?utf-8?B?NUY4a2I0S0F0anRJWjJxWS9iMVJ0RTJUak9mZjNaR0FHektVSTlDcytUOGNw?=
 =?utf-8?B?RmVTbmo3ZE43bjZnL3lJWjRSZFZQSkFFcFJlUzNDckRFZUVWNGIzMXB3ZG00?=
 =?utf-8?B?R0VCTGZrcHJGNXE3TVdXMjVRallpcThpM1lES3lrUkJQMmtVdEd5NjZXbDI1?=
 =?utf-8?B?bTUxeS82aW11K0RFWnpFTmIrNkcydVdhaGNucDh3VjNzZm16NVBVZWo5SjBP?=
 =?utf-8?B?RlUxcHZwZ1B4ZzdFdXlQNVhtdm9JTjY1T21HRlUveFpCNXYrWEM3cDJ2VnNF?=
 =?utf-8?B?dU1ibjRoR0FoS2JLL2xiZmdRR25NL21Hb2kybmk2aExvblgrRldaQzhmdXFY?=
 =?utf-8?B?cEtVRlFFM0E1WW81N29KOXNTRk42blE5Z25oWkNGQ2ZhdG9CdGdQSWhLNHZE?=
 =?utf-8?B?U0Z6ai8rUU5Vei9HZzR3RmpZdXc1bkJJeS9RWUQybmVsRDY1N2x4LzA1eWlW?=
 =?utf-8?B?UHc3UExiZDYrSzFlU2krVEZadGxxdlI1b1RTTzFWZ1NaNitsMi80OWpDVUR1?=
 =?utf-8?B?dFZMQkpGTEZNeTVGQmJFNHpzaDh0RVgyc2hLSXI2ZTQ2Z0k1em9HNWg2djhn?=
 =?utf-8?B?UG5abHRpRm1UbkQrcEFDLzJ5L3AxZE82dUVyVURRenFtZFJMdE9yc3I2OWVo?=
 =?utf-8?B?QXowLzErM2RJbG5mTkJNNE5wYVFaTXhFTWtRTXBsZDdleExmQmxnalNPN1lj?=
 =?utf-8?B?UGZMdnBWVWVVQmlQeFlNUUdUSERIWkpJMDVtQjlwc2JEYzAwenRGWFdabHpo?=
 =?utf-8?B?S01hZ0pUZXQrd0VFblIrVUJldkVIQ0s5VFJlazBHR3dwMUV0M3VjSkhCc1VH?=
 =?utf-8?B?WDB3UXlMUkdrQ3lkUDdCOFV5MEVEYTE3eXhORDFhMzMrQUxkekdQT0dJUTVp?=
 =?utf-8?B?RURRQWJReEQ5ZERPeGp2eUxHVERmdHV5VWN6Qy9qb0QrZDROSDN5KzdHRURk?=
 =?utf-8?B?aXB1dzk2YjRYdUZDUnlNem5LUkdETStKL0pkWnBxejhqQ0ZaMmVNU2hYN1l3?=
 =?utf-8?B?LzhvTUo2NnNHSTFQOE1hc3NKQ2dveVdhT2V2UCtHdmk5T0dUeVM4Y0NYWmZh?=
 =?utf-8?B?cURmN2VZZmxjL21JaHRIZ0pEblpIMTUwU3QvVWdzbHJncUdUTU1UVW9CUXNv?=
 =?utf-8?B?cXlsTk5Nb2gycHlLVFl6OEEyTjFhTGZibU05YWo2YkJ6QTdRNXBlSzFXS0FO?=
 =?utf-8?B?aUwwQU1OQ04xSlE5SUpEQkhIenZtakRhamd1VVplRy93ZGtTaFgrZz09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48019ba8-2ee5-4c27-c029-08d9fba5c768
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:06:08.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+KSzRn/iWo5lVzgkABqyAnDb/gZ1Kio3fNQQ3Gvzn3yHQPvlvu/dUovuP+KFsfLL2NOIFwEI17ccwLCZziu6F1sIYN9SEizBcFrV/GX3rayG/MMEO/r3gnLmCxdCWha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/1/22 11:59 AM, Jason Gunthorpe wrote:
> On Tue, Mar 01, 2022 at 11:49:09AM -0500, Dennis Dalessandro wrote:
>> On 2/8/22 2:25 PM, mike.marciniszyn@cornelisnetworks.com wrote:
>>> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>>>
>>> The AIP code signals the phys_mtu in the following query_port()
>>> fragment:
>>>
>>> 	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
>>> 				ib_mtu_enum_to_int(props->max_mtu);
>>>
>>> Using the largest MTU possible should not depend on AIP.
>>>
>>> Fix by unconditionally using the hfi1_max_mtu value.
>>>
>>> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>>>  drivers/infiniband/hw/hfi1/verbs.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
>>> index dc9211f..99d0743 100644
>>> +++ b/drivers/infiniband/hw/hfi1/verbs.c
>>> @@ -1397,8 +1397,7 @@ static int query_port(struct rvt_dev_info *rdi, u32 port_num,
>>>  				      4096 : hfi1_max_mtu), IB_MTU_4096);
>>>  	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
>>>  		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
>>> -	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
>>> -				ib_mtu_enum_to_int(props->max_mtu);
>>> +	props->phys_mtu = hfi1_max_mtu;
>>>  
>>>  	return 0;
>>>  }
>>
>> Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
>>
>> Can this just get queued up for-next or should I resubmit with the fixes line above?
> 
> Is it OK without the prior patch in the series?

Stands on its own. I think the only other patch we have outstanding right now is
the one about preempt being held across smp_processor_id [1]. That one has some
issues that make it more complicated than it seemed at first. In fact if you
want to drop that from patchworks that's fine and I'll resubmit once we get
things ironed out.

[1]
https://patchwork.kernel.org/project/linux-rdma/patch/20211213141119.177982.15684.stgit@awfm-01.cornelisnetworks.com/

-Denny
