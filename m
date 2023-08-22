Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6547843B9
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjHVOQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjHVOQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:16:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::700])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CFE61
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjUelWN834oW/dc4z/fj/jJMu1xT/3qHOlSzjy5PqJlavp6xYW+DRIXBERYS9YwQc/2sY1REjboewF2S9R7l5+oebxq6y5HQOfVKCmby5QS3diTO/IHzfbaZTVm485i/XTHcTtnLG6RPTJMsWCDMnuWtZ32pKtZ9grbT3hDW7Hcjyn0PhjwICs6HyOs46+Qds7IElS2+q5hKnI3+IInDeqncwDYwJJ8oI7764rR0z3B3oT4JW992EyX4DVNgzM8m5U426z2VHQ9uKEDacjHRVGqWR6xAQoecTbnqoiHg27yzj84NQzJIEnRHShlYVvfMslmDA6p16S22iiXAnXoFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgM+p6qdO4I3pZxcPjZbhWe7HcDkS88TiKj4NOfzsSU=;
 b=axYc7ntLFnpkyeN90hLm8/UBT3bVPmdnCJeeCD7RJmK/yrw6Lw1dtaiZRsQgBjjwGli+e16LW3cApmSQBelMJEv94sTTjonYwBUrmYHMzpOoOA4QrQgUwXaXLkXeA+tcZB23NsYBM+pyrGGzsuX7JWdMEPOCX7f41hZWiPdK/nwP7ox0VbQnulCHOFLQoLKQvrKgI4+l5Vaq1VI3aL8+hk2kgOjOwfTnH5NgsuDF4G72wZlD6rAbBrUpSzjHholeqy/BI7Du+f1ri1l0DzO/diqzny5F2CQ7dcJdPzoDGQQ0rNIeiLxfSVAThOoLT8W8/1B/pqjplHzr8DIVR2BAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgM+p6qdO4I3pZxcPjZbhWe7HcDkS88TiKj4NOfzsSU=;
 b=g4w9w5Q1WPiF8p9c1XKsGnpW2zj1bPJa09d8wX0HiewxvQYpFBDoNXmtimxcuVh2c5irvR7zL9BPDjw9UgY4V/RtDemmydGc44yvBz3PtnN9m8thV9PY1RTa6MCyQIRxMt9o32Q6ZsrXV07tlXH+L8KzrjKMwitC5jY3mXO+5nGpvXn9I5H/FrqaEcAVpScKV4+Y/31tJnwVXg0rxv1yWastOlmFztbPkFXEvNSSEhvYTExyqmh/7K0+6bmmeo0Gs8LIWUs9WbSA5ijMXNmVLZE4IwzHguIb+xHQxFnGgfEck5EmTmceXvq1yBEm3yvBYO7I79K+MJugyKJG3X+M3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 PH0PR01MB6214.prod.exchangelabs.com (2603:10b6:510:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 14:15:39 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:15:39 +0000
Message-ID: <d2797632-439b-8d2c-e220-e8cf2bff8051@cornelisnetworks.com>
Date:   Tue, 22 Aug 2023 10:15:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 0/2] Series short description
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Douglas Miller <doug.miller@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001641C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:11) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|PH0PR01MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c26ca9-6114-4309-d2e9-08dba31a42ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1Ool2aPjrxTg5K3lN2fYCS3/fJgHyWiRsF4lnKlYlQCmOLuMScwoRTIFvJNjZ6s5pZARqT1LTIT/Mt3HMYLMt4AhFPl9cYixPQdVP56uuYEiUB+1DsjsLA+6ITc/oP1TlJrVyp4D0RfbRT5LjsKo35Usj66dsU7pwHC+kYEiz2gSbJzSVyhFrT7GeDGwI4HmudAUsV/7QujWQGTc01/4mJ/5qmPMVhMGv4rliCpQQ0ewnaA0tCoYlkv2V9/AhJ5ChdtlAa/K8jVpGONYQCy/YjNLuduQCePOFuQNudAEL1L3HlZwM2yHQp9hGDJrOm0RV2uksXLnxeqPlnlfpjjpy9YRzyhCGDe/sTgmuu8Lhk0S/3LfpCMra488m+kUvecr6089BjT9yTPjQH0IjlPCgokOuVtZvYocZDBGypuOND/fVwFGWFRZpblxgVFXW1xbt9gOXolk2QkpZlHtYLliBHEVRfCOEhok/JCJH2RaDFvx9Ar5JbBJJTvodya8HSecCq/0cyNboJPwPfrH9bya1ZmqZJXMEC6/TFjKeImIUVZpOXOCkgcGhihgxUfcRRQu9hb13Jcb6k3gUst7VIaInNBatfYB99xY5zAThlGmyR46Za4RJ1krGx+J8Hls4+dsAZjODvTaN6QbPBA73XfkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39840400004)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(6512007)(316002)(66946007)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(38350700002)(52116002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(44832011)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzN2Vm9RcWlHN3ppMGU1MkR4blhNYVZ4QlpudTBvY2lQdzlIeW5BbXlnaVpZ?=
 =?utf-8?B?b3FLTjRyWE5PeDhqTTJ0Zmd0QStPVHY4YjVpUTlVa2plb0dFWWFPMWdqWWNa?=
 =?utf-8?B?TkdscVZVNkRuS0ZrY2UrOER5dHdNRnRDajVCNmV3VE5GY2IvSlV1cHlsamox?=
 =?utf-8?B?MTZEamIwZkNTYWhUTmdJKzRVMEE3SUFGSThVMnRYaWQraTd5aHNRWDFqQWU2?=
 =?utf-8?B?RVlSRldQbTAzOU5jNFYwTVI4Y2llSHlEMlNJZnBTcWwzb1pheDFKbS9jSTlB?=
 =?utf-8?B?MzNoOEVJTDE5SDhEOHpqYUYzVTJZTms4V0M2NlVrM1ZGckJUbDBqc000Rm9B?=
 =?utf-8?B?b1YzeDdETmJjSXN6Yng4MmtJSFluR0lDbEszZWJpMWd3TFM1SmJUaGRneC9z?=
 =?utf-8?B?em9PNEFPREd0Q3I5VUFZak0rNTRsT2ZndVkxR09RckdlSDl6R1EyNUZQWi9x?=
 =?utf-8?B?ZXlWYXpCbUhXMVNjdDAvU3lXRWZlQ29xR3hXR04wUjI3NEwxVHpwUTVkUGdz?=
 =?utf-8?B?QitXeERHVGZGb3BlaWt0UEJXb1BiVWRGMDZFdWdNeC8vTnhzR09lUllDdWll?=
 =?utf-8?B?OUYvZi9wYVNuTEdaMGN4V0pZMUlHRlRPUFlSU0NzcW0xMyt3bWh4UlJocUFI?=
 =?utf-8?B?Z2VNV3lrVGczczdkNmFzYWJjbXU0WlhSOHgvdXc4QzVYTmxWUXlQRzFTYloz?=
 =?utf-8?B?ZGtKLzBwUnBQVkh3U1RtZFNzUXpYUCtDTFlKNGl6aWVtbXBqSURzVDU2US8v?=
 =?utf-8?B?M0E0TXRmRHZ5NlI0R3lkYWNBNisrc1grcXhYTk56UzAyK0RBaTJoVnhlOFRr?=
 =?utf-8?B?eGFnVzBUUDlOWE1JbmtwdnVHemhGNFpybHcyNDFLQVlZNHJTV3REekMxaXBG?=
 =?utf-8?B?TTQ2aVo3aVdscGQ4VE1idmQzazdCejVSNkJaSnExM2hGS0k0OUNSSHpIajh5?=
 =?utf-8?B?aXF2NDFyNEYwcU1EdlZoNEtrWXYxUGx5YkhWSHNqRnF1RWhlNUlHUXJHYUNl?=
 =?utf-8?B?cDVaclFhcVpUTHhxTy9hQ2p1RWZYZVJtakRjWWtQY2ZqcTBSUDlCR3ZSR2wr?=
 =?utf-8?B?d2JxUVVpVUhsTDNtOS9MZmgzd1ZFZWt1YlZaUWNYcTdkUVJaTVZBQTg5ZGhZ?=
 =?utf-8?B?eXBNM280NWJRT3ZoenZ3LzhXcldPTm5OZ3RJL282R2FsQldPdGk1QTBIcXFv?=
 =?utf-8?B?U1Bzd2tGdFlPTzRvb3Q1d0tRZ0llWURPdk43MTAyc0FoRXpLL21vckRRYncr?=
 =?utf-8?B?dStlZm53OUlYTFRlbVZ2Q1hJbHVLRFFqcUlqTkZaMnJWeUQ2ckloUnhzY3FE?=
 =?utf-8?B?MlBEd0dUQzZMTUI1ZzBOSjB1MjFzY2d4STh4TWhyaFd1WTkzbGdQRDdmOEky?=
 =?utf-8?B?M0FZaTg1bzcvMXVkdnJDcTc5OCtRNGJhWTVBV3VDak4yMWNhdXh1cEV1Y0d1?=
 =?utf-8?B?RjhsSitmY2JuUmhERW05azI3aVI1b29zZklrVGdmY2svdDFvY1JNdzgzRTZ3?=
 =?utf-8?B?aXRaTHlMTDlEcG9KU2VJMU5OOW0vR3NBS2VWOGhOKzVDWEkrMlBJTzVqekVO?=
 =?utf-8?B?OUJrRllrOStYaU9oS2tRdFBRaElLQ252WVJJYVZXSVlHVnpTdUdnQWpqa3hy?=
 =?utf-8?B?cDI1dm9UWk9Hb1lxckZ2bmlXRlNqVEFGTGFWbFNVMmhrRDMwYko0UW9ZTmtw?=
 =?utf-8?B?S0VsanQ3NVk4V3pxNHpObTE2d1lJUnIzWDJZTFV4SU43cTZ5c2dMK2RoSEZ1?=
 =?utf-8?B?cUJ0a0R4eG4yUnhtcG8rY1lsZWxFVisxdFpORXVFVVU5SUZIcUREb09jWWp2?=
 =?utf-8?B?b0xUR095Kys4b3dwZ1lsbDQ5VjdHaVMrYU53ZXRVL3BjVlBRYnlLOWIyWmFv?=
 =?utf-8?B?VmZWRDJPdjE0SURCQTF2bVhkM2F6aVVZMXI5L2JPSlAzTlhjeWVsVTR0RXhE?=
 =?utf-8?B?QnVsYVRmMk9xMUo5S2pQMmYwMjR2b1hVbDFaOG5SWlpkZFljaVdIZTZrNVd5?=
 =?utf-8?B?QlAwRi8yd1hkRWlyc2pHMVJiZkxwQ0FKRk9ucnIvckdkRTV1N1lmUi9iRmNN?=
 =?utf-8?B?WXBFeHRoMkpGVG82OCt4YzFNRW5zbVIwOHkySlRScDlIelNCWmc3R0xtWS9x?=
 =?utf-8?B?N0Q3cUppKzZ1SjFSYytNcCtxVFBIOHYxMUw5WXVQV1ZLZFlHdjJCV3Fuclho?=
 =?utf-8?Q?6iPbkNnwLxZpVsw3PTUBJEk=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c26ca9-6114-4309-d2e9-08dba31a42ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:15:39.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcAfh6tu3wbgRvu1Sb4GIZvRwR5Eu6gTZFJVK+sXGhJzQc/hE8f6kFSmDS4HXkYywbo6jiMJGyVdJlxrGa3TI9DUzRVV69YsZWBQv3PU6CYJbM6UJLBHTiKbPPJmgMA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6214
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/22/23 10:07 AM, Dennis Dalessandro wrote:
> Much scaled down version of Brendan's previous patches. This doesn't touch uAPI
> just refactors some code.
> 
> Small fixup from Doug.
> 
> Would have sent a couple weeks ago but had been dealing with the isert
> regression. Reverting that give us a clean bill of health. If too late
> for 6.6 can wait another cycle even. 
> 
> ---
> 
> Brendan Cunningham (1):
>       RDMA/hfi1: Move user SDMA system memory pinning code to its own file
> 
> Douglas Miller (1):
>       IB/hfi1: Reduce printing of errors during driver shut down
> 
> 
>  drivers/infiniband/hw/hfi1/Makefile     |   1 +
>  drivers/infiniband/hw/hfi1/chip.c       |   8 +-
>  drivers/infiniband/hw/hfi1/hfi.h        |   4 +-
>  drivers/infiniband/hw/hfi1/pin_system.c | 474 ++++++++++++++++++++++++
>  drivers/infiniband/hw/hfi1/pinning.h    |  20 +
>  drivers/infiniband/hw/hfi1/user_sdma.c  | 441 +---------------------
>  drivers/infiniband/hw/hfi1/user_sdma.h  |  17 +-
>  7 files changed, 510 insertions(+), 455 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
>  create mode 100644 drivers/infiniband/hw/hfi1/pinning.h
> 
> --
> -Denny
> 

My bad on the subject line here. Should be obvious what it's for though, small
fix and a refactor patch for hfi1.

-Denny
