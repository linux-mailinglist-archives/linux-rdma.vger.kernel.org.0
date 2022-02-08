Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD7A4ADD6F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 16:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382017AbiBHPtk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 10:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbiBHPtj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 10:49:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF52C061576
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 07:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4nLx4PhMReCZ8yZruJAcV/wFlg5K9VErKawCElOJK09O4TCXSJGaIq9VBcDf1WgsSR60DN6EFOEaGtI5GmGHQKR57bxR+b6d18TM0ubTK+KzAC19OHvaZQZ3cjgbFRjc32y45kpAO2OJnepw9PwL4KZ07ojbcm6Au0zmMIpf0/tq7BEVhO5Y49DfMECE1w8aCmXBSlTeCCXAy0U3bdTxjC6u+q1M31LcMlHu6Y8SLh3wSL4KfErzq98V91uYTNhmVOTCjcMY+cNwhiGMJiYBrTPyCRdjz0iEaRV9VohVBsmwWybHhEiHUJjuDbZZ5Hcb/90SGQG9uJnR1hIlnQHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5JGkog2BaXNFT++T2wqvSlK+84pfLWRqNslGeDciW0=;
 b=loXq6SNvHaR5h3OatJep+u0HCT+ykms+RqgiiujBIVU9ZTFBFSkDPRReyeRlPtKMUlVB70QOlMeYx0OmEp8d0WmZjz0KTvu/TYhi7El6p242ihYXO2MG/tRwM2iT2Px2uR3OFvnsMZBNdsco1IfP1vHBnItBfnAbF3q6bcWp+zH9yNVHyShVA5MGZLfA6XV4SrD5A3JhQPA/8YlAXD6wxjezuUdNR8m4QThu0Bzdm7H9Qd2PRjxZpkKzsRsB+qYQlwe4wqwA5HZuwX2/0d+ZKh6eCregx7C/tM3ICNpaRXtmO6zi2D3uFKu/mCwKkL4Tafxcgl44QoBCXVZtdHSrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5JGkog2BaXNFT++T2wqvSlK+84pfLWRqNslGeDciW0=;
 b=jF7lexEJc+iMS7mBWV2wpi99qr9eY80L+9EHusEUu8teZmu27+UZuoYExUcQH+lx2wzQ2A1xH/jmYamuPFAPz4mCyCiiJP5/oAK8/XgBPSrco2XFO3Bn37XO6kPDfKm4RbxENSxk71D7haO6jq3mDgVfRc01huDruT2tP/8zW0DPCAd/yXUI3phdjqEmr3IUO0oefSvT+BVmMDRHDW5/grqeAwTLq4cnL+LhnLzw5N2PCoUniNEd97+APXyVfiRm1aVFFNy2Usrd/JVxeYtnQWm421NKeYTPog70nnx39owgPiwEw6YtQNbAgmh3Vseo6+Hg5XUYhutrMUnJ5LVh2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 15:49:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 15:49:37 +0000
Date:   Tue, 8 Feb 2022 11:49:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org,
        Ismail Mustafa <mustafa.ismail@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Add support for address handle
 re-use
Message-ID: <20220208154936.GA171050@nvidia.com>
References: <20220120174041.1714-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120174041.1714-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce72e1a7-962f-47d9-041f-08d9eb1a9c67
X-MS-TrafficTypeDiagnostic: DM6PR12MB3323:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33232B962E5F0A7F818092A1C22D9@DM6PR12MB3323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgSZD32kEoJaNQWQWosKhUaVSpw6wFp3fH1KSL6wO19zEa3wItwKWKA4MPKCfcSE6KDKhEYtultl5kYuf2euDnt/VfQ/vScHmCBD6Z3vh0768DRv/nVMU5s9pOKwWw2PJ0zxwBGoj0b34+0GSg42R85S2D7JlgbBbxtX0ZgzrPZKobVWfs0Ao/CNTX3/sYMu60igjBdBIGIOUDQTa5FadSwJc8bCr+jj3B1KQwAx90pPohOIoMcfaAqQFJdUkq+dG+0AlvMPGvkQ6t9TbM7kW55kO9RX2UNKpl+NsWXjPfOtPRNgahkaAHQ8a8puFWqgBNePRCKi0/UwvcxiT7wjEmB51hwTWXXSMeIQjbrhqyCMEo//TCKh5pYMHM7yLnO9K9WW+Jlul7cfDD7cym6zC4NWWOZGGsPOGFLOVxLWeKCChKhhFvQ7DARSf7z7Shi+HbNeUvPiosm8fCw4TLXA1eP+GnDyMePKnAg6omtvviA5yDyRB/g6me5DR3sGRQNFsCTFCfhCMp2pAj5vLuQBDbpWkyGWvFsF7UAbUxGwKzk791LZ/dLdqw+G5MlUL++YT2vTqp6FTqt8rf6YnsBKaNHj7HrRY95PPpWEdN5fOYlsHgA7AkL8WIUGlW6WzQ8sKaApVEhEL835PBARXvHjj3kn6V0U6fMfek5mFa5v2Jmdk8nr2iR6zX0k7BTtLztzp+eLaKiGZeqA/c4JU0frgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6916009)(8936002)(8676002)(508600001)(6486002)(66946007)(186003)(26005)(1076003)(6506007)(6512007)(316002)(2616005)(4326008)(66476007)(36756003)(2906002)(86362001)(5660300002)(38100700002)(83380400001)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuA7e25ZFdF2HPMha4p7c/GZc5JQ6ypwkCBmldVX+9AOdYCpjERJVrSqMbo/?=
 =?us-ascii?Q?Qwh48gHk9qJdz4ebySRRSGiB1INxXczBn05xU6g6yBcvnKIg8u2D8a5n6VfW?=
 =?us-ascii?Q?IB/9tyJrzsPc3/xc45DDGzdxrz1Cnzykv25Z4/p1TPvYn5osfPyn9fu4K7ly?=
 =?us-ascii?Q?ZI9N+aaVq4BiLELyMcTWNsbRn4Jex1TmFxo/HRlbnZ8RfpNAIbnq3Eqfismd?=
 =?us-ascii?Q?5LfUKiXPi01VeDVm8vwV9g6aV8hAmjPghpnIZ+1Ldr8efFQvKx6dNyDlNx9b?=
 =?us-ascii?Q?or6VbK3FY9r0b7Z+igFcBEuCmGlVsxxtROll9i78c7acTbclnu3hm/4CrRBD?=
 =?us-ascii?Q?rIXRRbMU+/17frTkfOAv7Ns62FvH/y41oXxXE/zAsK6Up8ikYecVo2gtfpz9?=
 =?us-ascii?Q?+JvPEuaFV1ENgUSA5Vstpioyu5qt6ZFoMTszmE1TpstrEuJAYyISOemG7jO0?=
 =?us-ascii?Q?z83NU+D49M6/36Aje4vE5j8sTK75XJ9+keeJgcR4RxOLOOULnn0JMM+R6h9j?=
 =?us-ascii?Q?qZnflSMSpr1g4Y5F2nqCNcmovKou32b2lvdJWNUZ0km8iYCQlV7IXbGTZMRV?=
 =?us-ascii?Q?FEa/1CJZGGssjQctyVTnoAA1uiYieBR/xuO0SIeRWKHXEUf0+6DvqMOCFOW1?=
 =?us-ascii?Q?9hSccMNEiHNyBtS2SBhEPZJhTHphpHbcwkrkdSGyfKo8a6rKCq7EgWuQEdpI?=
 =?us-ascii?Q?Lmkxc45r0V1jdv9zxMK5OBJpkd/OJPTDXSN5aVI6S1FtXduzD8o6pA8Vra0y?=
 =?us-ascii?Q?lDZH88XRHQhOZiDxYpoHs8Elb9GHQQ/Jn1WHWGfAlU1M+cylHnDY285SN+VN?=
 =?us-ascii?Q?YHGMqikKQuAI3Qq1qxzhNSkxwonNRezlN4PUZ0kSt/RYAkGFgrNpsFlXPPPK?=
 =?us-ascii?Q?Teh9ULyK1k23J2gyC7PKZoqVs+nYvvbr1D8Fu57vVGRYKoaOuUuf1MxoIdbU?=
 =?us-ascii?Q?MNhD356h3hNPLNk7883iJv2KT98ZIFcp+NiznTSV2tHEhaI1vEC1uOEnVAuB?=
 =?us-ascii?Q?ZPac0XHT2tJZR1R2KwJem73gYkMPa1xlI3zeF57elkt8DdouFPoPAWvxs3vX?=
 =?us-ascii?Q?BOMOvUmygyutAs2b/qKF4a8zkL3LnUzYkcRMn2wNPLiMupbwzhHWSlgqX7et?=
 =?us-ascii?Q?wf3YOI7qEZREfwINCwKmaZp89hhQCNVJ/uAvLmupFsjhfrrlQKTuz04O4MKW?=
 =?us-ascii?Q?T2F6pbS5BAP8cJkAvnyharOvwry7JowF3hSj5nB3z0nQs1c/hIycY7WCMnWG?=
 =?us-ascii?Q?S66+c/dVh/MLD4p8775crBvnDHax6XJehbjA9cCdj8aheGWcSrHvyQaMZnMW?=
 =?us-ascii?Q?zdv4u0KCk0TeapzwEVvGe+LkwyQdrkBrqYDySGo+OCe55ilISibT6LmIomsR?=
 =?us-ascii?Q?bdBMhShMhucw3oM0OQkRS8iu/HDGKU3T/Lwzj5SDDEI8UC8+qtTak80gHBt9?=
 =?us-ascii?Q?Jta2mb27wChdCC/pN0/Fv7b9eu4aky+GrQsJOjp9QD7OiJ7mXTn89CSli+bW?=
 =?us-ascii?Q?MyX3vjUdt7aGgnMG5znbKE1SKkl+LYvV9T5uhJi8vRBGe1cCWEH8FYXyBqzT?=
 =?us-ascii?Q?CWrPusJwa+ePvrTgTQ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72e1a7-962f-47d9-041f-08d9eb1a9c67
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 15:49:37.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B67ZHDlKa/ur4N1MZMal8OE61ySqDJWTyDC1zxcsJvR1q3BL6lLaH8foH7G5SJbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 11:40:41AM -0600, Shiraz Saleem wrote:
> +/**
> + * irdma_ah_exists - Check for existing identical AH
> + * @iwdev: irdma device
> + * @new_ah: AH to check for
> + *
> + * returns true if AH is found, false if not found.
> + */
> +static bool irdma_ah_exists(struct irdma_device *iwdev,
> +			    struct irdma_ah *new_ah)
> +{
> +	struct irdma_ah *ah;
>  
> -		if (!cnt) {
> -			ibdev_dbg(&iwdev->ibdev,
> -				  "VERBS: CQP create AH timed out");
> -			err = -ETIMEDOUT;
> -			goto error;
> +	list_for_each_entry (ah, &iwdev->ah_list, list) {
> +		/* Set ah_valid and ah_id the same so memcmp can work */
> +		new_ah->sc_ah.ah_info.ah_idx = ah->sc_ah.ah_info.ah_idx;
> +		new_ah->sc_ah.ah_info.ah_valid = ah->sc_ah.ah_info.ah_valid;
> +		if (!memcmp(&ah->sc_ah.ah_info, &new_ah->sc_ah.ah_info,
> +			    sizeof(ah->sc_ah.ah_info))) {
> +			refcount_inc(&ah->refcnt);
> +			new_ah->parent_ah = ah;
> +			return true;
>  		}
>  	}

So, the number of AHs is so large the HW has problems but you propose
to use a linear search to de-dup them?

Are you sure?

> +static int irdma_create_user_ah(struct ib_ah *ibah,
> +				struct rdma_ah_init_attr *attr,
> +				struct ib_udata *udata)
> +{
> +	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
> +	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
> +	struct irdma_create_ah_resp uresp;
> +	struct irdma_ah *parent_ah;
> +	int err;
> +
> +	err = irdma_setup_ah(ibah, attr);
> +	if (err)
> +		return err;
> +	if (attr->flags & RDMA_CREATE_AH_SLEEPABLE) {
> +		mutex_lock(&iwdev->ah_list_lock);

User AH's are always sleepable, no need for these extra paths.

Jason
