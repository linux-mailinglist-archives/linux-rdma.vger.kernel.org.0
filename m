Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53E52867B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiEPOHi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiEPOH0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 10:07:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0EE3A1BA
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 07:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX5r5Iax2SrKzXoMyy/1AhjEr+tWYfrwcxNF/eqrDEioFI3Fm06yTOmq+OZ5rEMAYa02le2meLWJ6xBwIVR6xeEI3liVqmJGG0ltEdBO7rApwpiOy1QQdA+tmm5pqBHTQeZiZDRXCJehftgBzC5D/rsl7vbS1xkSuXEfn7qyCjjmcBfZq/v3j9z1nldE2DNQG/ySE1NTfnEQOh0yr+9NZGwwBwjCE5dxFw9Mbr85SXPjgoi3uPqvYGWGJ2MpfbctDie5cxevuejk1pTX1DlHwx7z3bujCThEq2TLwBuXRxouNUL0lNa2cJueaWP2Lj8uCLIs2hWlXkgViTHyEY7eRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqyCopvu0YsGNE+tJeZcnjvoBxy/JPauk4IT2PSnyFw=;
 b=Hl57o5quWXgyDeGbFnntTizVhnne8Wz98fuxydNaxihVfHE74T1+o7RAhG1ZmsaQwut4OXrXtWFuRJEyKNVWrSHiVFvGL2JY2JUiEvx7CpNh1IisDQGUeeY5q7MKFFhmoKIjoc7nba6WGiJKtDc+/xIAIJQNMVD7Mn6y92fO1JTXksUw5l/z0/dEFhTg4VeX9zTk6uSl4TH/FclAM++FgMrJQzrmAZ3duxT2Lyl2MqGB4ZqAslQoeLygQk49I+uY8V9HmOcsVti+7VhJc6K0Txyc3KyljHEMEORjxXfvEtOwRW2RPx4b6hkYWF8MUQHpiKJNNhp3YK/5UibNOQbFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqyCopvu0YsGNE+tJeZcnjvoBxy/JPauk4IT2PSnyFw=;
 b=Map5AHOWiigkklMbcGZGnzItc84pn2ZIz3W2M8KqbrFIrloDImogrNSLgRq9+5YI3iKgf9nuj83mu7EzfEJDQvFxkP+EZnsXwTNvUv5ldb5g5Eg0RadGs9brYbTzbsyHZ9Bj4f9BXITV7QrEITuQf4HlSclimH7WHNHx8PcsMQN2nUAzJs3JgXU/RfBzOywRrYcKq5dvQjdAYh+7kuq/JSBuSktJn7U0eGNrzWaTWTYsuezNjLI6nxFhfQqVkZirmsIYZqXrukQGgv/GDDBITe2XZh8AsByRgrumVPLJpYxJ3eidKEGA6UUvi2vVmgQhybiYv70UFVVyy1YKOVi0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 14:07:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 14:07:23 +0000
Date:   Mon, 16 May 2022 11:07:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220516140721.GW1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
 <20220516114940.GT1343366@nvidia.com>
 <3bf3f0f4-1592-2aa6-42c7-f1b4ff73fc6d@linux.alibaba.com>
 <1b6dbe3a-8b15-3c56-5353-27525095962a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b6dbe3a-8b15-3c56-5353-27525095962a@linux.alibaba.com>
X-ClientProxiedBy: MN2PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:c0::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea52e30-040c-4fda-92f7-08da37456601
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB281030846BDDB97F1E7C48F8C2CF9@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SP69oIyLbRXbqrHVZ6aLVPk/ZmPhVJFKL46DZ2Pr3yLNki8xd6yIbXTdJwbMcZ9OMiCWM8I93DF++b9YpKen0N5tngFjFVRoFWQHXc5gttL5eR1YoEpIGSDWbH7BRxoxQKvj2vtr9AXTbwE9Cnt9grIOHwXixiXJxRp+GsglELL/Yvci7lGEfRN+l79p3urogN0KoU7hbhOIG5IDLwD4E9QtEv9YjHAhHXenOhRMiufw5Df1NDZs2FFp5+WCWoR7w+cEkKhcU5qfUiY8TnBcMnyQj2t/0W1QHDRn0RUROX9f/sxKnRHGbaNAQ2xQU0FvzHQuI91di6Brh6ds7L08uZiSCeM8pB/ObOFFh+vUotF/kTUPDvDe1lqmj7LvOXSmo+cDyg/1U2z61/eFGlSLHLQCAm5q2ITgj7cC6hWBGm+8I1Hgg2wLPx53R1tBjDIZxLtPUrm+tWetzpCb4h41xNHKM+x/MV+KB87ZPRTz6rity9SRBXEVNo2xUUEVJOmQKUTH0KTIuHZoFjWYyH6Hurx+HsWCzIoqMIDkUykix+FY3cEeccEuh0wU5urgrf0cQ3FowV98GkMICzZoj3OzE0YE3ru20H1TqlY5tjnayI9FAUeHOcz/dwY6pME63s9Btep7wB1NlwTyCfcEyaUXd5/hyIowaHff/NsbJd7a0GDAb/HhsNIF1Qsm4uSM7Lc/PU9WrnhKeycXEeuTBUgSkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66556008)(4326008)(6916009)(6512007)(2906002)(36756003)(186003)(33656002)(2616005)(53546011)(86362001)(66946007)(26005)(6486002)(8936002)(1076003)(5660300002)(508600001)(316002)(38100700002)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlvL0o3YW9lZDFVbzErL3JIMDRWTTRuVWZNSk5Kb0U3Z3lleFJvczB3ekpE?=
 =?utf-8?B?a0NlSVBSN3h1bXN6NExBajkvQmxISzZTVDU5aVlDbmZFY1IwVThZWTIzVWpE?=
 =?utf-8?B?RktybFhXS2R3WndySnNIemtDa0VZYVViOEFiOUR3WUprdWQ1cWlYS2dHVTd2?=
 =?utf-8?B?NVNXQytLZW15cEVsYU43eTBxbWlheWlhd0c1NUJNZFhUZXR4VWdCWityMDZC?=
 =?utf-8?B?cmVzNWcwSDRCVkR6eTZ0QzduMzJwS1JYdXgxNDZ0NjR2VVZ1R2xXbFRkK2dx?=
 =?utf-8?B?MnFBeGR6dDZ5RXRYVE5HMlkxNEdINy9ZNzhKY0grcDk5dW9iaDlyYWVUZnBH?=
 =?utf-8?B?ZE42Qmk2NGF1STkxdDErZHpxTUNkRTBJZlFVV1YwN0dManpTTC9XQzFWa3ds?=
 =?utf-8?B?b2V3cW5SUC9zMzVtU2NzUk1TTUdFMUFlR21IWUtFemp4eE9Bc2hVVStVVUtC?=
 =?utf-8?B?eTVyVnpVaGlTZVV3d2NrSzdYaTdkQU0rUE9Ub2N1UnBrUk9Jd3Y2WG9hcGJM?=
 =?utf-8?B?eGc4aW1hOGtmSHorVkpxNGs0Vmd2ZFhtb3MyYWs4ZDl0YTZyV01rNExYSlF2?=
 =?utf-8?B?S3lRZjJKZDVnUkkvY1FzWHNnREl6cUoxSGJ0VytvbG0xSmxHL1FjTkIvZy9C?=
 =?utf-8?B?bVcrQzM4eXcvQ2ZENDNxNFlUWWlZb1piYWlxWlF6dzRndGRteGMxY2J3Y2F6?=
 =?utf-8?B?L3ZXMDdVZ284WWdZS3g4cVRDb1h6QmI3WmtjbXdtOUIvaUMzS0NMNERSNjZi?=
 =?utf-8?B?N1NKWUsrRVJJUjhXeWt1NnJDNEIyNEdGWFdzeUFLRVVEcjdhMmdqSWFwam5n?=
 =?utf-8?B?NTY0c0JRSk9Jc3FYenlyODJzbzZDbWNTVStwK2EyZWR4ejlWZkpWbWdVSk9R?=
 =?utf-8?B?ZTJ6RU45aXZIZHlISGc0amZSR1ROejdzNXhRbGVJNVlac3R4eGFRSkx0SXBJ?=
 =?utf-8?B?QjZuMVhFYVgzbFhXUUhlVFFCdjdSSXI1bEZiWkE3Y29xZTBlYjJlRXU2QXph?=
 =?utf-8?B?RWVoY0tmVVJRNWJGKzBPcmNLODQvcWpOSWt5dzRUdUhET1AzL0lQTktNK3Zu?=
 =?utf-8?B?NHBSQktZOHprSEZuRmhIRC8rUkJRdjUwdjN3cUNzWW53MmthQWl1YzYyQ3dX?=
 =?utf-8?B?cVgwek16eGR2U21LU2pLK3AzUnNBSURhaW13UTkzZFlzWFZXNDZDSHIwZnU0?=
 =?utf-8?B?RDg4K2dOcWkvOXdSeCtDTHRKd0J5eUJwSFVtMzR4cDQvVWFqTjdzcGsxVmZ3?=
 =?utf-8?B?NXRWaXhmaFhBVStwSEtpQXRhemlTU1M3ZGhqN3NkNzdsTDVMMGpWQ21mYW5C?=
 =?utf-8?B?bDE5TmJaNlFpQ2NXbzZrdjdnZngxd1RaTTBwQ28xdlBkbUZPYUZhQzZuaHNy?=
 =?utf-8?B?SDBCRlJBRTdXTFp1VnV4Si9uUmZ0aDhLUFJqVUF0c2VPeFM3L05qZDV5dGJF?=
 =?utf-8?B?RHhBQ0dLTTBZL09wN1RWdmRIdWc1YW82UHVwaWVpN0g1Tk81akF5TnFKRE1I?=
 =?utf-8?B?SHFtRlNRVHMvaG1PVnZVN1phWEtPS0h2bSsrNWxCeEVQbGFTbmtWaDhCdlJ2?=
 =?utf-8?B?ZFRuMlhWd2RhalpmekFJK2xpWU92bGVEWUJDR29wQWpjcEtOdnUvM2YvY2Mw?=
 =?utf-8?B?K3p1QUpnWmk5S2VJc3p6REVqWCtmb0ppUHZ1S2FWRjUwQXJMUzcrRFFtb1Aw?=
 =?utf-8?B?d1JOM0pLREVWNXBvYy93NUYwR25SQUwrU2s3SVNHNXpTZXhxT3B1WkR6Yldx?=
 =?utf-8?B?MVg1MHVzSXhJdVFwdXZkUjZCQ2hYTzdGUkdVVklrTG5NWlp5STg2NkI2dE1J?=
 =?utf-8?B?UVZ4V085KzZjbFY3bHRuSllQVHczd1I2cjZxMVYwMU9obVNJekFtdUxSbFFv?=
 =?utf-8?B?MWdqOFZteWhaN2xwTElOek0xY202TG1JMU5xVlM0Y3BDQkc1ZHlwR0wyU3RX?=
 =?utf-8?B?SGRQR08rbE5sSGpqUXBHamZHUFViVDlpQ0ptdS9Gdm5nbldJM3R5K0dNYnMv?=
 =?utf-8?B?QXhqbFk5dy9UelNONm8zeEhIaHpCd0l5K21JR0Q1emFQbXF3K0NEUVRhV2RZ?=
 =?utf-8?B?T29DT0tHL3BHSk5aM21QRXZrRDlod1Voc2d1cUllUk83ZW56K3lnbXRhR0xi?=
 =?utf-8?B?YXdDNnVmYmovcys0Z2psYWNMdW9hUjR2WVQ2L0tDaWFXdzF2Ym9zWnJ2L1NQ?=
 =?utf-8?B?eitQRUpOcU9leW9JUXZCNlh3RW0wUDUxZldFU2NrcDNqaXpoN09QaGs1Zjd4?=
 =?utf-8?B?aENvM1J2d29KdFJMMzdINGdBNnN4UDVSMWYxNmRyZFlnelpTMWFxa2dOMlh3?=
 =?utf-8?B?aFlLWUF6OVVibHlwTGl2bHJnbGg5TS9pakxsTDI5WEUvSFFoOVBnZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea52e30-040c-4fda-92f7-08da37456601
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:07:23.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA3ZRSLM78cDfWua7FEBGKqcfNZbWR/InJf6KCIGCmFTzOMnNlxTYx8bZY9vYo/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 16, 2022 at 09:59:28PM +0800, Cheng Xu wrote:
> 
> 
> On 5/16/22 8:40 PM, Cheng Xu wrote:
> > 
> > 
> > On 5/16/22 7:49 PM, Jason Gunthorpe wrote:
> > > On Mon, May 16, 2022 at 11:15:32AM +0800, Cheng Xu wrote:
> > > > 
> > > > 
> > > > On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
> > > > > On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
> > > > > 
> > > > > > +static struct rdma_link_ops erdma_link_ops = {
> > > > > > +    .type = "erdma",
> > > > > > +    .newlink = erdma_newlink,
> > > > > > +};
> > > > > 
> > > > > Why is there still a newlink?
> > > > > 
> > > > > Jason
> > > > 
> > > > 
> > > > Yeah, I remember your suggestion that the ibdev should keep the same
> > > > lifecycle with its PCI device, and so does it now.
> > > > 
> > > > The initialization flow for erdma now:
> > > >       probe:
> > > >         - Hardware specified initialization
> > > >         - IB device initialization
> > > >         - Calling ib_register_device with ibdev->netdev == NULL
> > > > 
> > > > After probe, The ib device has been registered, but we left it in
> > > > invalid state.
> > > > To fully complete the initialization, we should set the ibdev->netdev.
> > > > 
> > > > And the newlink command in erdma only do one thing now: set the
> > > > ibdev->netdev if the rule matches, and it is uncorrelated with the
> > > > ib device lifecycle.
> > > 
> > > This is not what newlink is for, it can't be used like this
> > > 
> > > Jason
> > 
> > 
> > [A typo in previous reply, so I re-edit it]
> > 
> <...>
> > Or, Is it ok that erdma registers a net notifier in our module to handle
> > this?
> > 
> 
> I think this twice, use a net notifier of module can not solve this, due
> to the leak of all ib devices information in erdma module.

I don't understand what this means

> The solution may be simple: register net notifier per device in probe,
> and call ib_device_set_netdev if matches in the notifier callback.

That sounds wrong

Jason
