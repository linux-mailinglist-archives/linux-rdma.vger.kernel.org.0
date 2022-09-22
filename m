Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8925E6913
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIVRDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIVRDB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 13:03:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D798F8C0F;
        Thu, 22 Sep 2022 10:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z94MQBLe16Nm+I8bxpE8TPCdo/5rJ0Rv/JmTeGll9aQjC3s442BdXZ+NgpH2fJd/OCLrWyYOAOuqr3OLRHgga8+WuDNsOc/GwPCDvAh8dCJ+WdxnHeCyuTBl+SJQZ8JKo2maS1N8iodHDlD5UnG/iKeyFVcMd5BfJuwwCQ6vXSfJOEIQrTajxWl3Noe0Sd6KwNYVMN36N5j6A48JmdjyVdlPwWq1MdZpJSyaMDRaMEbicBj13yuppyEZK/gq7X+Q6v4Wi16YoFPs6+8mpGdswdO/oA17Mb5RlGK0NgWftGwlhH+nGL4HFbVGUrQXyKCZzNeEGynX/a2qU0vfc2T1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LMBGMYgN3VpYrDq5fT0zcHIe5jBiO57XG+h6Zw3R3M=;
 b=NAfJ5xgrzSNnHsU4fWCZUoVvZGpKbTv4/ErzXZPf/d07K8CO4polPdhUJ7o8V5a204dURd0pkCBb7XaigVPhDTmp81ZEwbuwYSWeb4Qaa028nf8ra4JgNGXfGPLXq2RaluguTXnkwRimucqyROjtKNX1G8qSvp9MRAwZ5G/fAqmZzaoiuc047BYr6ACf1FGVxjb5f+p4PLZ7EB/1ou+tLSaCZZ7bZGGRq96Xfdx1FmaWDb2qVv+vNyVTjbDIJfMiR4Oogg/hgJDLB9+hrXZ8zskrXy+rJS6Hrq2O8xQlALA8i4QCth4jano+PHR7+dMK2bXeUAZu1RfDWahdvSrABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LMBGMYgN3VpYrDq5fT0zcHIe5jBiO57XG+h6Zw3R3M=;
 b=WhEStiyAzFHeO+76N0DK2YWnyYjop0CSmXdx/V830zA4t9QzGrtSkrricExkVJJGKMMMygeLoHjZ32FiYmWdTRTxBHnkSoyWejQ0CtA4I2UDtZvzgm/oK7WMGUn9RpQ0CX27VMd8fqW+9zpOI/WvpuP4vtPQ3vH9TPO+oSqU2Aflral5s7AhxShXYOPfLF6MCIziI7fnm9h0U5/1EKtmJe2bEc4Tj85UMt4l7L+Ni+hNpR/vhUMBG1HwFDkPpzOKAiLHstEImlbdSuW8g2gZbd3W7vi/E0ffRRFdLEe+FqI/TcziqsH3G98wdliiEA+ibySCP9zrtQfid2FD9sAwYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 22 Sep
 2022 17:02:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:02:59 +0000
Date:   Thu, 22 Sep 2022 14:02:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     jianghaoran <jianghaoran@kylinos.cn>
Cc:     bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
Message-ID: <YyyVQcbFCinWT8Z8@nvidia.com>
References: <20220901055138.1704755-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220901055138.1704755-1-jianghaoran@kylinos.cn>
X-ClientProxiedBy: SN4PR0501CA0025.namprd05.prod.outlook.com
 (2603:10b6:803:40::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: fd545acc-dbea-49d4-534d-08da9cbc4d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAq2/WHj8zShwdCa3029SklE9rZGjalMSR6ggHDLNyESmoDwXEdtIHZX3pRoxd1oEAyWKGVtOHtftFli497hxuPEWuv21I+dW71Vdas51tCYFCHm0kxR8rRP9txonYAZqZcImBzW+KzOQnLZUC95ZGCCVI1ywEbUP7q0etD2gP3oV3P4X7HdjnSTBSfAhG6SPJKQoiJREhsN08ucBPzcHD0efhMjONYiDSXfFsunEq16fWIrkk16MrqRXPP736kay9DnDHnxOm4mn0M7c9BgbQIAAyRUcsCkGA8xaQ50h0Jv6eFU5sRDOOpyWi7tcgQhcefCkCOT9kttJalwKqZ/g8dNybG29H4pwY8VQn4wIcFt8jkNEJ+fIzMlC+pC1oigpq2rK8Zs5Af0eKOR9nCtyG3T3bklw4OmmQd6/9Lpgfh4QzAW+Gqvtl/tHGmnMKW9YUa6WaYDGAQX5Wc5H8zbQ1/8eRd1zUTqATf26kKPj+7KSKQq/H2gNa943ipxcD5Se0FY3kM4cDx0zAn32qAYUX811cyzfGpkM46OxaR8ASLp/m7y8syrixJZ/G+dNNS4IchorEXnCPgDbx52iLojQV08/FwChwAfVoJeZWE2trXqkNOerYbOeG16FwWD9qYrkSkw5oX/6oZvrSLzNuGQN0HhnWgHPH4uSs0u8AFi7WpcH7BW8YbbgL1X7vguLHYg2kvCvpcsYHOcP3oLmyhMZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(41300700001)(36756003)(316002)(5660300002)(2616005)(86362001)(2906002)(66556008)(4326008)(478600001)(66946007)(66476007)(6486002)(6506007)(83380400001)(8936002)(186003)(38100700002)(6512007)(8676002)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlnOEoyeTFGVEd5TTVpcXVjcjNRalFBWjBlRlFtUGFCYlpDUHloVDczRHdJ?=
 =?utf-8?B?cFlpcWlIZWRJelVndGlua1BWV1JMTGhRa2NFM0RUelZjWUFWR0NTZW8rdWNL?=
 =?utf-8?B?UG41SUdZS2dXZUdwalBvdHVLTW4vNTFjeW1pckdBb1Q2QWFwMWdtK09tUHg3?=
 =?utf-8?B?WVhCbHpqOGRGN3gvSFB4WmZadUdJQi9ibGhhdjk5QWtPclZtaitQd1RuRWV1?=
 =?utf-8?B?QWg1RXM5QjRhOEV3bFpPcU5ORkQyU2thTUFXNVVEY2hCSHUzZFFiSUc5MlI1?=
 =?utf-8?B?Z1hTT2hRY0V3cVQ2UW16VmlxWGd5clJ0akFtSmZ2MkM0Z3dnRm9wQ1dqRHdq?=
 =?utf-8?B?NWJaa1B1MEZ6U1ZzYzExY3FwUjJoZGp0S2VwUnp5YnZHOWJRZmkyTTVnWndv?=
 =?utf-8?B?WjZTY1BzYjdwQWVOZ1hLSmZrMFhkdlJZOHlXRXhSZE9YbjVpOFM2T0h0SzhM?=
 =?utf-8?B?ckNMVCtIRi9aT2R2L09oV0Z2cjk0VnErdEVoZkZ6bWlNbmVVMnB1MHFnSTRz?=
 =?utf-8?B?N2R1RkMxL1ZsWHpOSWxGL3Fyd2VmaHVHSlo0U2xSazhHNDJKSktqc3Q5ZWtu?=
 =?utf-8?B?UG1McVREMFpFdTVqaTg0YzlGeUt1aTRlbFBHcktibWNDWjlyWUhYUStReTgw?=
 =?utf-8?B?dnBvQk9PaFBrckkxbjdHaTVRQ1BMb1FYc0tlWlY1djhia0d1UmhrYjFTYm9z?=
 =?utf-8?B?RlFSODZXdXZUdktNdkRMSHk1aEt5MTNyUURydCt0QVd4b2xoWmdNaFJNdTl1?=
 =?utf-8?B?Vm1wVThmbXhzRkJURnZuYmFSOThuTWtVcFBLdGRJZS9ualo4NG9rQ3FSM1ZT?=
 =?utf-8?B?VHFlY1BzL01DMXlkVnVRL2NPK21zWTZmb2NHdkZ5RmlhTDk3SitZNXY1Z3Ir?=
 =?utf-8?B?T1ZSdlZGSUZpRWJlSnhiY3cwVFgxUnNQYjBhblZ1Z2dsaXlaOEdkaTdSb1Jh?=
 =?utf-8?B?TDE2eG1kL1Izd0xXSVVUU1hPNnUwRjZ1R0RocU1oWkk2dzJoeklTcXhkUzV2?=
 =?utf-8?B?Mm9iZ0hydkd1Y0pneEN3TlRSYzhxc1dXRWloQklsalRVU29rejE4YURCT1dJ?=
 =?utf-8?B?VlZxcXZ4R1I4bVBEMEN6WVA0aVdGdG15dHh6WC9OSDFxM1AvMXNiM2hRRGd5?=
 =?utf-8?B?MXk3RG0wME5KeUtJVXFpRmtNSGhmbm5wbmRCa2xyckNlelN3R0cyZkpxWklt?=
 =?utf-8?B?eElta0hUOHE2UmhKdEk1WUdtNXQyUkovMXNkNnd5MTNTVHNEdSsxQjFUSnZr?=
 =?utf-8?B?a0dhZ0xLdEl5YkJON2NuTThyT3F5d0N1bkRmUFAvcS9VNXcrRjU5NksvbmRx?=
 =?utf-8?B?cFdieTVsR2hxbXIwNXBhM2trWGIrcmIzZnRvMXZLbDlSaXpoS2pxcUVkcW16?=
 =?utf-8?B?T3Q5Q01HN3lkWVh3ZGZnWFU4dUdoaFVtd2l4d29NdENBQm1pNFl4RW5ud2Mr?=
 =?utf-8?B?cWlYZkhMankwZzhWNzNHRlY3TWRrTlFsVyt0QmpYQnM3YUVnNzJnUGM1Vjh4?=
 =?utf-8?B?OWFMYlhydVZOd1U5Uks0YjlHSHIwZ3lmMW1keXRmUTN6T1hxeWY1eHpTazIy?=
 =?utf-8?B?SjRTWXM5SENqTzJqaVlmcUNJcldLTG1nWktVbDhGY0U0bTBUMk5jRlVRcXJs?=
 =?utf-8?B?M2VWVEhzdHhRSFY4NHdTeUF5K3lndHdUNzUrdVI1YzUwZzZxY1AvdFZ0VXdo?=
 =?utf-8?B?bndCek56eGROVnpqVXdBck9xb0JhalI1bG9TVVJhaDIvZHg5ZWc5cHBxbFgz?=
 =?utf-8?B?S2lYSkMrKytEblIxdmtoNTh4V3BlVzF5ZXBiRllBZTRRVGVTQ0RsdGJFY25n?=
 =?utf-8?B?VitnUEtEaURXYmxkR2pSMVcxR1lyTFRTeXpMUjZFZGl3eTdkM01Bd0JSNS9r?=
 =?utf-8?B?SmIxcmE4c29xOUEzSTdzbHUwdkNyeXhySWlFL295SytHdTNXTG5KanRmejky?=
 =?utf-8?B?RnZodWdjN3RYbWFrcnY3OHZUZ0NXNHVQanRQTDFuY1ZXdzJkREpOejhlaVFj?=
 =?utf-8?B?NExoRHV4YVBPVGp4aDBEdVRLNDNETEoxcmdPd2pxOU81TzNUNFRjV2tvejk2?=
 =?utf-8?B?ZHVmWU9qZ29IRmllZUZPVHBOaVhJbTgwOXEwYzljdWFSWlpVbjJ2OW56di9k?=
 =?utf-8?Q?PFq31htMlk0XAO108kPOFOu0T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd545acc-dbea-49d4-534d-08da9cbc4d20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:02:59.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGNdDwbK/OsucGn5xX+ovrqUdBLY8goSagmTV8ZiEG+fzBYXzfXPHUUNcxhBNgZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 01:51:38PM +0800, jianghaoran wrote:
> cross-compilation environment：
> ubuntu 20.04
> mips-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
> 
> generate a configuration file by make randconfig:
> CONFIG_32BIT=y
> CONFIG_RDMA_SIW=y
> 
> the error message as follows：
> In file included from ../arch/mips/include/asm/page.h:270,
>                  from ../arch/mips/include/asm/io.h:29,
>                  from ../arch/mips/include/asm/mmiowb.h:5,
>                  from ../include/linux/spinlock.h:64,
>                  from ../include/linux/wait.h:9,
>                  from ../include/linux/net.h:19,
>                  from ../drivers/infiniband/sw/siw/siw_qp_tx.c:8:
> ../drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
> ../arch/mips/include/asm/page.h:255:53: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
>       |                                                     ^
> ../include/asm-generic/memory_model.h:18:41: note: in definition of macro ‘__pfn_to_page’
>    18 | #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
>       |                                         ^~~
> ../arch/mips/include/asm/page.h:255:31: note: in expansion of macro ‘PFN_DOWN’
>   255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
>       |                               ^~~~~~~~
> ../arch/mips/include/asm/page.h:256:41: note: in expansion of macro ‘virt_to_pfn’
>   256 | #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
>       |                                         ^~~~~~~~~~~
> ../drivers/infiniband/sw/siw/siw_qp_tx.c:538:23: note: in expansion of macro ‘virt_to_page’
>   538 |     page_array[seg] = virt_to_page(va & PAGE_MASK);
>       |                       ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[5]: *** [../scripts/Makefile.build:249: drivers/infiniband/sw/siw/siw_qp_tx.o] Error 1
> make[4]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw/siw] Error 2
> make[3]: *** [../scripts/Makefile.build:465: drivers/infiniband/sw] Error 2
> make[3]: *** Waiting for unfinished jobs....
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: jianghaoran <jianghaoran@kylinos.cn>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index 1f4e60257700..55ed0c27f449 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -533,7 +533,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
>  					kunmap_local(kaddr);
>  				}
>  			} else {
> -				u64 va = sge->laddr + sge_off;
> +				unsigned long va = sge->laddr + sge_off;

The compiler is saying it should be a void * not an unsigned long.

Jason
