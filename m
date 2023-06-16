Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30273361E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbjFPQd6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFPQd5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 12:33:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34135AE
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 09:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4M4y6K3YrkdVz1Ftc4r+6DRVKHaFyFRcYp1XNhdvEi23r2f6KgPKDRaf5RGpkpxR3WlGhaQw3cWEwwVXOFcr2HWK3E5/LhKB0dp8+kEPiO4pvjX3AgpHKtk2WTGcV0Xa4xjoTyxtuv8UeS0vIrKlzCAEWFKhkrbFiaIvTLTMD1XCbJJiFMoFe+H/43ptkwy3ksBQD3e/vLQl3F9rwR31w8Kg2lkgQCNrkqJdOx5pBDK+prpVrGimTTfSTX5lIjug6zp1YKu/+jpqcqzgRc0RRkBiMy7+cdiNt4/weLu/KlbDQ1Py561VXoYuaAN+ncAgiFmJR6+7Kizc5E0TY1E9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4e601fi2tq62L285dKwaMdjCeyTp43KTl2lntw/n44=;
 b=Emwqp/iWON3rY6+WGTpfYJfL1sG8KYiTkTxaKpiGnJdXdOF6RDyhF3kv9Af+jCdO+PYJP1nTjPOeJV29eyt6J9U0uV4sChiDfLWFuH5t7ceww1yliRuitJ4dp0sg73ngS41MzmlyNrObjOhLszgPdir01SOkYJob2+Psln1gTz15mQw25cJnYZsQGh6wS2i8Aq0iw962XqtSQWshVDNPIpGUuJyKBd0TZbsUwKfLnOicrgg4dkKr+AGh+CC92VDylOM63GQu9G9cZFudykbLauX4r4SMU48bHtqFq/ydTl4T6qrouMjPAstvqNyRPlVUMMacReqEpGozttN2Ja9Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4e601fi2tq62L285dKwaMdjCeyTp43KTl2lntw/n44=;
 b=eBgn7uKvGDizriiwXO9JTzEdW3gHLejAd+y417eT9/wP3fSpHadkp1j/ykq/LRKDYBw1XG7DAcHJ4KIKQO0eYzE3EgzbvCOBHcdrJ113pBZkZp//RFYmXlDprHvfwGiU3yDE6FNvqva9FeyYQ2gkatH1Wartylq7UYM4lb4/eNgUFrnhUb3ub4lSxfHgeDebUtnielV46DScQZqgHBbz4aABcimsicH0SIxblEJFd+Jrkl5hkBQ46MAvtdb3K7Aa/HHl6WhW7AnsuHaC73xIF9T95ZIrWUdKDRttfdT4PIbZJdSI6jhzlsmmIyd0l/a2+vBnSI4Pqowl1ydCePrtPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 PH7PR01MB7583.prod.exchangelabs.com (2603:10b6:510:1e2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Fri, 16 Jun 2023 16:33:43 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%6]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 16:33:43 +0000
Message-ID: <ee887b74-929e-739c-f472-cce7ea7a4d09@cornelisnetworks.com>
Date:   Fri, 16 Jun 2023 12:33:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
 <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
 <ZHnx2xu/AmkKFni4@nvidia.com>
 <97b685a9-cd0b-023b-75f1-48c8df06a2ad@cornelisnetworks.com>
 <ZHoln/2UL7avEou8@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHoln/2UL7avEou8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:160::31) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|PH7PR01MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a729ec-ea8b-423c-5e8c-08db6e8772c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlLu4enhi5gZhC1EpyLrpmzkIqZNqUR5BNsN/GINu5287pMRw5E/9awBF/vrCJPmT/veq6y4aiyEMnPESetxjkaW8+Jy57m5SQG16Z+OGOuib6ByZ+OREMcgthmyoAwDQh5sZ0jFPI/K/pT3+srGjdSBJhRMJAz6FcQUXHcxuLwkyFuNZdz4lgDi2hm0i0O2OiHKsE4pTrCUuDbme00g4ug9MFowbIldqM3P2Zt2CzelkNgWX5hg7njh2Sm7Awo+4Wqd3dpHurBhz9EaQ4b3Y9KWAmkhr52Q8jcxzqarRZ5nQfHO7v+NwZGeCM1b+p0NP3pWcETNGDfNBT4AQcd4bhPPWRLLAf+PegX6nXeNhUaYWehefDb9T3949k6oCAP1d+Yj+cUz1TfkOBy6dv2miXYb7SIbCPDqR+/68wejWZJpmBSlLr3Zx3cZqm9PV10ZMV/osiSjhvithNELJwdDH8w4VrfePXn8PrwtvTfxp3YgY8gJrVXsS35abtOW0ZF7ftsExtsuCuS/0H3gE3cq1QaHwUk1czaTYGzTJ5lBf/ALImghZeo+Q7e0VekGLYVCjDV5jrQmf+sM7trbRf9NoHdsO8GiBxmlmDmL+uiwmk6PYVB1wNqSGfINRl5auzvQuOwJwUt/O3gkbSzBHzaZ2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39840400004)(136003)(366004)(451199021)(186003)(8936002)(66899021)(5660300002)(8676002)(36756003)(316002)(41300700001)(478600001)(6916009)(4326008)(31696002)(66556008)(66476007)(6506007)(6486002)(66946007)(54906003)(38350700002)(86362001)(38100700002)(52116002)(26005)(6512007)(53546011)(31686004)(2906002)(44832011)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9wSXJQdjk5Z3hmMys5OVptV2M0cHBSSlVUbEpFamF2dXlqNVhVbzZ2RHgw?=
 =?utf-8?B?TWY0ZTJhcDJ5VVBjamZJTk5NNE8zRTB0RzBRZWZZbHhMQ2pHSndkNld6UDBq?=
 =?utf-8?B?S3RiLzcwYTFlRDZRRzJ6Y1RJdkI3THZZUE1Fc1FHMjd0YXJRclk5V25qbFpv?=
 =?utf-8?B?c0U3bWNvT2VmalMrWWxsWEh4bUNQZ2NFUGxwNlB3bjgwK1laR0VwWTVWaUVJ?=
 =?utf-8?B?dWFzYit2Zm9xNFVEUlNndTRVcEtsWTV6NE9NUnljeWNUOCtIbTE1Ly9kaG9s?=
 =?utf-8?B?K250R01jS05xcGJjL1VNemxxenNqd1ljWm1ZWmN6aG5yOVRjaWtBYlNUM1k2?=
 =?utf-8?B?WDNhbTVKODliVFdTcVQwR3REV2o5RFRQanY4cEJJQ1lxRnAvRFJCTlU3UjZj?=
 =?utf-8?B?bVFWcG1CdWFlTmJyRzVaOXp6bkF2akJ1N2ZtYU5lWC9tMFhUbHRzNSt3U1dK?=
 =?utf-8?B?YmZEVVAyRnpVRlQ4OG9vNS9vdm5pZm9uRmcvU3V6T3daWGhmOUd6d0hxeWN6?=
 =?utf-8?B?YXZMVFRCUHoxMmp2VWU1YnlvWW9YaDV3WXkvTys1T3RwOHJmd2RabWRVOXpq?=
 =?utf-8?B?Rjh5MEZsYkxYM2tNck9Nd3RrQmlrNFBFeGtCNGlVeFVpdFpocW9nczA0dW1y?=
 =?utf-8?B?QWhYNWxWcEZ2K1VqYms3UE1wQTVYeThDdlhzanBrVXFhcklwaVBUKzl4TWpI?=
 =?utf-8?B?akVpV0IyY3hTMEIwWk55VGZOcFNoeElEbGdpL0g3MHc1elBEY1lUbHAxTFoz?=
 =?utf-8?B?TkJidjRURC90N1Nhbm1VQzFDdkQ4VElVVWJQMnZ4R2hpK0NlYkljZE1wTkNl?=
 =?utf-8?B?ZERPb1k4WXBONXExeDNPRUNJemh6QmdLREVKNnYxMVdKK2FvNjJ4QzJ4U0Jr?=
 =?utf-8?B?Wm9zS3YrdEt5NWRGMStqZE1WSjdYREkzS3owSE9HdWpKZ1VTa0ZtMUxxYkFV?=
 =?utf-8?B?KzRzelFpaWpIczdIb3V3OTVydUd1dFVwdXQzU1RXdjJ4YVcvNFJ0Wk1ZNEsv?=
 =?utf-8?B?c3NFbitnQzY1VEx6RDZ5eExPakQvSlJsS3JYRG5iRzZsaE1ITGhQdXVYZGhF?=
 =?utf-8?B?aFI2YVVPR0huTUFKcVhDUGZTSVIxNWFFcEJSQ0JVaGdhMm85dDdtVFJSeWkx?=
 =?utf-8?B?MjFod3hiVWYrZm4xZWlyMWR3YWFRNVY3K3FROFFmNHhnWWN4R1I5YU9pRkVL?=
 =?utf-8?B?YkROYkpBYXFNUFJ1WUt2U0l3dkpTUnJsd1lZcnBhT1FaUE9oci85cGlMNEM1?=
 =?utf-8?B?UWZJMlJkQnh3bEE5N0JQVTZSSkdPVDFaZ3lhUjlUazZpblRuVk02WWxHaVpu?=
 =?utf-8?B?R2Z2OTIzaWRXWGhjMXRuZUxNK3pEWVQxWG5MWVN6OWo3M3p6QUFkMittWW5a?=
 =?utf-8?B?ZnhvVlFqZmduYVdnbVpqY1hidEZNVndvT2xSajVSTnpIUGVvRFBORTl5eEh1?=
 =?utf-8?B?OHY1cjdicTlvT3o1Zy9Yc0RUcWg2QVpQWkxxZ1o0SkNLaFV1Vmh1Zit2V0x4?=
 =?utf-8?B?bmc0OE1GOFdZTVJjNmtjNFE5YUVXU0c2SnF3bGI0LzJtN3N4Q3YzK2hiV25t?=
 =?utf-8?B?RjQrbkFhcUsrSERrNWVuR1FlVnFtODlCdFVFR1BKcXFaem9Ga0c4MTl4dDFL?=
 =?utf-8?B?M0plSVJOd1I2MDl6amp6NHJUZzIrQWZIR2wwM0Y0OHFST3p0eEdFM1hUTzdZ?=
 =?utf-8?B?dmxDa29QY3RtL2lWQzM2eG5uOFNTVFlwNFRkd2NyaERHcDlzTTgzdnFHMEJv?=
 =?utf-8?B?VHR4UU85dXBZOVNhQTdqeDNXTmd2MmxaaDZoMGEyVVArOVBpRHNmYmFSemFJ?=
 =?utf-8?B?R2hDTXprMmpCNFcydHdqZmZPRGh0c3hQczVnL0ExblYzMExuVlM0eDY5cXFj?=
 =?utf-8?B?OUN4dVhBN3h6Wnk5MWtpSnpHWGRSUjlIeTdkcFRaUU9jVVFFeC8xRXlLZUIw?=
 =?utf-8?B?RXpDSUYxd29tQkNqWEMwMGxRVzlpUkF1Q1hXbG5ROGFlMmxHTzNtakRCOUR5?=
 =?utf-8?B?YjluVWNoYURzS21HUUJGK1Q0eFlPWHVrYjZzMDJ2UWEvaTlrejZ0WkZqRmtx?=
 =?utf-8?B?YU5kZzlUdmxQdGY1Z0Y4b1JSMTRBSW1lcXM1cVFNb2V2R3BwVzMzMCtyTnNo?=
 =?utf-8?B?YUIybGJjUkNPbENsUXpDSzFJTFZrMTdKNDJSeEVpcnZjV0FSNSttMGRPb1lV?=
 =?utf-8?Q?m6PpILc5tlhnjLADd7p1eJs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a729ec-ea8b-423c-5e8c-08db6e8772c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:33:42.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPRmWthmesH5bBw0hGJ1PJ54XKo6/nrHxW4AHNwZzPbh7JRstJugAPH29p4r5st7Jm6xZoaKt13aYejKpvW2KsNH5uaHG13vFMov4sGq8EFgrl+vtQP89pPwsuad94Bs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7583
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/2/23 1:23 PM, Jason Gunthorpe wrote:
> On Fri, Jun 02, 2023 at 01:15:47PM -0400, Dennis Dalessandro wrote:
>>> So you will have to think carefully about is needed. It is part of why
>>> I don't want to take uAPI changed for incomplete features. I'm
>>> wondering how you will fit dmabuf into hfi1 when I won't be happy if
>>> this is done by adding dmabuf support to the cdev.

The cdev just needs to know what type of memory it's dealing with. We expect the
dmabuf to be allocated and ready to use. Just like we would a GPU buffer. So
would you still reject the patch if we sent support for AMD's GPU instead of
dmabuf if it's all in-tree and upstream and we have the user code to go with it?

To me enabling this support for our cdev shouldn't be that big of a deal. It's
in support of our existing HW. I'm still committed to fixing the cdev once and
for all. However I'm planning that as part of the next gen HW release. I just
don't see why we need to tie the two things together especially when the only
uAPI change is to have a way to pass in the type of buffer that is backing the
iovec, and I guess should bump the version number as well. We aren't adding any
new IOCTLs or anything like that.

Regardless, specific to this patch, Brendan has reworked the patch to not touch
UAPI but just do the refactoring of splitting out the page pinning from the rest
of the SDMA stuff.

-Denny
