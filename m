Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877CB3F2064
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHSTJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 15:09:45 -0400
Received: from mail-dm6nam11on2103.outbound.protection.outlook.com ([40.107.223.103]:24542
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhHSTJo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 15:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XINxwIv/mCzKuGIeqC6NBe4BPcpgPfDlfv37SaCFEyjQLMagkHkh1j7r5ei6Z5xyR/KKJZ5u2o8TTt5Yn3J2lxQJhF3niLRzTc/bmZVYpOQuiCte+CarQjjvzx6FwmlSrm9I2b3U37j92G+Cq+K7sQ69kOAu7YwL6tEjyMJMJSppCcSdn1IqUmPxnJOUzmCnKDuLyEUkU+Lu2g/t0MUaSgZIvmTzoivvroY3zf5bWtSoUQKELXrlKBpD1Xhkg0SEtIHKOKL9Mjp9VkR6+e+R1rFKb9lY6fvq1+GTpBAcpOp7XBh+Zv287tx7Xf+vKImxsS0cy/42tSU68jOwp223yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iddj0+tQN200kHHWvKDX6M4NKB+iXxuyjkfKu6z1nZ0=;
 b=WhW4kB+Bygk1a7gZm+z2IZKNojeuoMa/Si4Pd8vYDQGH3gGz3T1EcXNn5KcvxNfWsWmnNZeBb8+b2Sn7vXkgHQ7LA48p/lBWXMTbDrEKHofxquQWCvMS5Zb9DiieyOKoDO8g4A5/w8eSmxAZk0Or+Xt745f0XFY4tSVDFiigzWgC637EApIbsI1v1qvS8SPlJIUTKuHnelZP354VzcfEhZHLzS/h7JrzwrpFoCu58Wsmcxp2GpRH0TtDwg2scJbJwYXmXHR//T3b/iUx+FKtEhgsXf3zsdB2qYSIbFJ0niaF9DjySWo+qoyIYptehn9+Z/zDA/qTJdJhCUGa55hEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iddj0+tQN200kHHWvKDX6M4NKB+iXxuyjkfKu6z1nZ0=;
 b=lb56zV7e33FkEtRoWd/F9QXJFpMDWeGXnLIDWIcc/46YjJrloerwn8QArGQb+JVGzvmxKNsBTcuii7Nz8+dNv85z97TPyE/rgHsiNba9UirF/uiQXUF0xqH1i8lmoVtJEAsIweikKD9lcyo9/8vnTU/Wz2TPk4fXKwNd4smRy/K1VntvXpFVW/SxqExW/29oTws8ryL+mqH0Vwf3N6patbdHMXZFM57LWyUwJ5S6CKGjRCqPlOsJEKvdc5bWl+v8t+L36BMVbydIPCD9aJKO8X1MnQsALvkqonWXLOEXDnrQK0xRoD5YhGROHUUFONGnSbQQFLJRAL8LWJTa0fyH0Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6296.prod.exchangelabs.com (2603:10b6:510:a::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Thu, 19 Aug 2021 19:09:05 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 19:09:05 +0000
To:     Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     kaike.wan@intel.com
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [RFC] bulk zero copy transport
Message-ID: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
Date:   Thu, 19 Aug 2021 15:09:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0011.prod.exchangelabs.com (2603:10b6:208:71::24)
 To PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL0PR01CA0011.prod.exchangelabs.com (2603:10b6:208:71::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 19:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da50f8e-2f48-471a-47d2-08d96344d033
X-MS-TrafficTypeDiagnostic: PH0PR01MB6296:
X-Microsoft-Antispam-PRVS: <PH0PR01MB62966FC1D14B169FDDE73A4EF4C09@PH0PR01MB6296.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pL43Ao1AsmTAt4q30KdHFNwqvCZfuo6jKt3HCehLOS3fKjdsvsA24dJgiS+6ifv9i9Wkn6XB1PuRyYY7g8DDrLr7Xw7h3p2KfTbTtL+iRLAkhFsnx3rmduCYAHn4NVWWE/g6OFDRlZxLp8MwSTRWt0nOIzgz7YdeYoBtbsODd5uuQLkr3wkNbOIehNM4/1Vq4pik/plPZabgSbbfST+4HKBSAvgQn1XFFd/lIXgsC0/QfrgOn1fuk22aB/uX6VtcpnDrhR5eV1PXNp2IbnyBveJ4hLmiZd3pVKDR4C62n0Ff4EoabZfjbOmSnJoXMrEG1RSgzlV9105XmZ1pLZ7mce+8rGBCJPs9OEmZWlr3qqTdw0e+JFEPT1cb9iZIWBV2vSUeqzRVtArN38InB7ZfDAS3yPQKw9PTYQxWF4PUiGqX3x88O/+QmYPQNcJtpZAgQXiztp+s+7uLEP7mCcruirFF446RbzAZe5rM10A7l1hMjXoeo1ESDgAQvkOQZ6nZvpKQt/TY65Tv0gtwy5nLjNCt4XUjmqxNacyYRRk2FnyWMwbcejiipVsy/Ys7CAyL1cocsOJwOotxFB/BFS5UU0+ajtpmSHN7DfGu7F8Ewo35SPw3zTgVqlXbI5g582rTj3W/Gb6uyKFGQCsbrxeJInNdNDnCaLX0ktW6+aULreBOzoSxIRucc8FpCqy4sNrvJPmcU7+q7Z/KiqIZYXpbjZFxoFPv/UD3nMdLYUaWZ+b6jBQscyHF4qGITGRtgLh7lrsWnTwM2pXDrSCU3UEizbqr0FBne3XjknLO1yC0pgaiu7NO8DNTQFEtk0CcD7l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(478600001)(38350700002)(66476007)(66556008)(8936002)(31686004)(52116002)(2616005)(4326008)(966005)(31696002)(44832011)(6486002)(8676002)(38100700002)(26005)(6512007)(110136005)(186003)(6506007)(5660300002)(316002)(36756003)(83380400001)(2906002)(66946007)(86362001)(956004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTluNk9IU1dDVzBUY0FDcHZ6MGF2VzBkUThqU2sreW5aekJZVkFxUWxFdjZo?=
 =?utf-8?B?cng1VWpESmRYdTJGRk1wUGlRZ0dXMkFuK1RJTDczTUlwc24zeDZkM0M4VDBN?=
 =?utf-8?B?N3g3U0lOeHNlRkw0R0Y5OE9Eb0s5dVY3V2x6Z3lqZ0cyTFhuUHBycEMyQS9v?=
 =?utf-8?B?UkJCWDlhNUVCdE12QUIyRmQ2UHI1dlZFczg1V3FTei96Q3RHejMzWVVxSEcx?=
 =?utf-8?B?ZjMwbDdZNklwNTNQOFdGQ0dxN2ltRnZCeDBLK0ZscFB6UFBCNnM1dXVEbVF5?=
 =?utf-8?B?aFRKZUl1VTVWUFhCMHpXWUNYZ2dqdmVZakZSd3ZOY2dVU05iVGZ0Q1B3amt0?=
 =?utf-8?B?MXJPK1JTTHZOQWM3RmFrNk9peGUrL2I1OEQ4UGJscXN2RWN3MWRvTnA4bVNs?=
 =?utf-8?B?eWpoTnVMZTZkQ1hoa2RKc3k0Y1NxSVh2MDEvZkZ3dEtVb0t2TmFjb3NPT3pT?=
 =?utf-8?B?VlZENG9IYWxjeUlWV2RzMjBUeG5reDdEakJIZDB0VGxTdmcxNzBjLzRWbG9R?=
 =?utf-8?B?Kzhsd3hXdzR5R3F3UmlKMjhVTmkyVlM0cHlrYWJrNzRURTIwaFhVU0NicVhU?=
 =?utf-8?B?NXFKNkhjUThyQ1ZXUDUrKzAxM3NBdXlhVzFWeGNPczYwbnExVkhhSldJRkNl?=
 =?utf-8?B?V0R1eXRDdkh6WnlDYkV1M21DREd2clFhajFjeHp6TENoUlR3Ukh2L0s3SVNo?=
 =?utf-8?B?YXVxQnN1eWU4cnU1ZmFEalVTaFlPN0g0UlNiQkJQVm5GU0FxWnRITDNIWTZj?=
 =?utf-8?B?RzlHUmxHd2tRRU9nY2J1M3JIckNhN3BiV2Roa3hWaGxkdjdiS1hGSldVeTAy?=
 =?utf-8?B?WHhaTC9aN1pqQzVhZWRaU1hBd2RQTFlrU0pGYzBWdGdHVDBNZS9HVE5PcDV3?=
 =?utf-8?B?WDUxVFJESVdqUkRPanIwYUFzcDlpZzJJK081N0RhdnIrZ1d6WUtEWFgwWEFy?=
 =?utf-8?B?clgvMTkwdWlBRHdpeGZPUm80dHgrM3diMmR5OVM3TkxPbjUvOGYrMDN5NWNm?=
 =?utf-8?B?dHRaSTFxb1hkNnA4T2xNWkZ6T1JqcWVJNGtsbWpMendId25vK3d6WVZURTJN?=
 =?utf-8?B?eWQvQzZJRklJTE8yanlGMmpWT3cwSEwvQW9nT0ZxT3pEc2hSSUZoYlhJUWxl?=
 =?utf-8?B?dEs2TGV2WEFlNHVPQ252YVQ5bUNuaUFYUjBISjV6YnNZenBxNVBFNGFxVmd3?=
 =?utf-8?B?Q2VpOHpmN0NyeHZjcENGVkgxZTZNQVBER2IzMmNQL1RHZ2w5Ym9jZjk2K3Yr?=
 =?utf-8?B?YmI0UnYzem56QnFWdHlVZUROSVlTeWkzWGlmRGFISE4vNEtTZ0cxdEh3eU1r?=
 =?utf-8?B?RTJxbHoweHJoNHA4TnFORUZkZ0VWZldlRHBwU2Rkc1daTXZPd3h1eWZTczhy?=
 =?utf-8?B?SGNCcXRPbytTeTd3QVA5SUNMYlFLOS8vUDAwYURLZWRheTdINUdPMkNDeE5K?=
 =?utf-8?B?MVQzb1BIQmoyUlBwVklUbkZTMXpPSnNuclJjUm10MHQvQ3FNcUNyRUhPQnlF?=
 =?utf-8?B?U24yZExMWW9ZNmE4ZDhwT1pCWU9tUnY0eGt2Rk5zS3B2SU12MERTTjVWRjgy?=
 =?utf-8?B?TFIrMFdSdGYyS1BlN25hNEZ6NHBUSElvd0VJVHlKR3NESDc0cjFsZGdFUUV3?=
 =?utf-8?B?VnZldEpEMS9IM01FSjd3eFMyUFV5djE3L2VTeDFBSHE1U1J2M1IxNEYzSzZD?=
 =?utf-8?B?cHFNTnlzY29jWHY5ekV2WVpCeXpyalRiUEVFWGFSZ2dPNzEvVDg4RXNGUlU0?=
 =?utf-8?Q?uQIsMJ900OeI7e5D7ZPvsriBykcYynGqRmvpYIj?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da50f8e-2f48-471a-47d2-08d96344d033
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 19:09:05.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74RgKI04u0AR9Fvg5a4+cJSsDp6Q15iWsAzz3j7ZNPBNo7DWDj7zATKSS9KZ6Zu8XQ3ww+SP8TUFaY8YecUR/56hNCr2FP6AU4UNPb/8hcAtrqHT+RpgsIKIqGq5ZMhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6296
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just wanted to float an idea we are thinking about. It builds on the basic idea
of what Intel submitted as their RV module [1]. This however does things a bit
differently and is really all about bulk zero-copy using the kernel. It is a new
ULP.

The major differences are that there will be no new cdev needed. We will make
use of the existing HFI1 cdev where an FD is needed. We also propose to make use
of IO-Uring (hence needing FD) to get requests into the kernel. The idea will be
to not share Uverbs objects with the kernel. The kernel will maintain
ownership of the qp, pd, mr, cq, etc.

Connections we envision to be maintained by the kernel using RDMA CM. Similar in
fashion to how RDS or IPoIB works. This of course means an RC QP which allows
our TID RDMA feature to work under the hood.

We have looked into RDS and RTRS and both seem to be the wrong interface. RDS
provides a lot of what we are looking for but it seems to be a bit overkill and
has higher overhead than we hope to achieve. Performance results show it to be
less performant than direct to verbs.

After reviewing the RV submission, I don't think there is any reason to try to
revamp that submission. It seems to be very tightly tied to PSM3 whereas this is
meant to be more generic.

At this point we are interested in what questions you would have or opinions. We
would like to get some feedback early in the process. As we develop the code
we'll continue to post, similar to how we did rdmavt and welcome anyone that
wants to collaborate.

[1] https://lore.kernel.org/linux-rdma/20210319125635.34492-1-kaike.wan@intel.com/

-Denny
