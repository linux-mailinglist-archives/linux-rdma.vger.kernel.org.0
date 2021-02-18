Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20731EC27
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhBRQSP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:18:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhBRPff (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 10:35:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFTkYc135765;
        Thu, 18 Feb 2021 15:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zw1SDQ8TY1ix8cGLh9ijMxx2xyAPBY9P+Splw/VEKVQ=;
 b=xxlWTTTiPlkK/UShz4RiIe6ljQ6j+BwYC7A57wg56zVz5Zx9no8ph5b8hXcNJwLTsM2D
 0lR0B54x9UoxWHq0CsrG6cgis/J816VjM0+CneOpj1V/UmjvxQB20HGPBoOAtQD6LFWu
 tNavW0742iOvSONIvElIrtjzCjwvMG0QRcMjCou/gEZAAp1EifIACaB74C0xKoOR5WjH
 Wgu60WXXtqV99WSQt52NdNrFgt1QIL2oNDWZaIAscBYpSHr7C/8+8W1mJcojHWloQToH
 IUyYqVPp9M8jKFEd5v3nblYTazXFbuzX3VskEWeIfnYdv1RGxMy1mbY1NZwaSzhJMA16 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36pd9adtsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 15:33:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFUKcv184000;
        Thu, 18 Feb 2021 15:33:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 36prp1p0ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 15:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvljleOA3nydVDkWPG23CTnnZQPwztapJ1UPh8RxtDJV6lS06qPQng4vuieFGN3zsPZlrO/faGfY9H77f7WHFDtDxTJAi+PC5ddzeOMrwkcgh1h1DEdgSUHztTUa5dfx0S00bZnUGt3ulauBvcrpmYGxrq4ju5TwJhCigG8cH1rK2jUmx/Q1if4gvqma/v5q9G15HG3eazfWS8DYVVMjftjqo9aVpwRKCgOEwr1EJs2WeUJAo8kRkRqb2KAjW0Ob92WXErHdV9UzmfQJCVS0XiAAoU9GFqcOaZDTyhFQi8OydNzxhrRuE9opw6Wh0n4Dvw3Skyl63MW1Saul3NcNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw1SDQ8TY1ix8cGLh9ijMxx2xyAPBY9P+Splw/VEKVQ=;
 b=TubVVULR7kX7BiqGmzq4JVBaas5WWAHZ31gwhmP+stHt6KDtxTeTsIA9hg7RDU/VbOjX5nF3DNgLqLe3vW41w1uSj4Dkn3ytaeYGmNXAoaVTT4DPxf3vXX98qXIqxWuaAmxB+q17P48L72mC53GYMkpDTQ08nXog/dTWgfhuMFGFNQuyBffZKkzUwlJgdJFD9vJIwmA96AbYmvewyxk9JCUhyLjEstqq4jdecaGymITjAtTdMvKDGRHW26o99HIKrb6WjYY86u64pu/zanEkvKjJFIP3+dOOW+MrOUYiuXgZTGVWs4i1VKdIGyvZNqqpeAeHEKJVIwCi63WRsv/pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw1SDQ8TY1ix8cGLh9ijMxx2xyAPBY9P+Splw/VEKVQ=;
 b=KR8Jv+4XImDxmBFrsJxbAcjb7tdtQn2exgoctXGl6kgEohWnhiE2WNZmAGIV92GYPVadITKMqnSxcG3nvyVRxu4U33Cwn4fyRiFLvfkCvkqq2sqd1lo4frVwOAxYhSpuQNWQMNwqSDCjoDeqaKRc216gtOhLfbRaH/f6TGE9E54=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2901.namprd10.prod.outlook.com (2603:10b6:a03:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Thu, 18 Feb
 2021 15:33:46 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 15:33:46 +0000
Subject: Re: [PATCH v4 0/4] mm/gup: page unpining improvements
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
 <20210218072432.GA325423@infradead.org>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a5f7d591-f3aa-1a54-569c-bd1abcb99334@oracle.com>
Date:   Thu, 18 Feb 2021 15:33:39 +0000
In-Reply-To: <20210218072432.GA325423@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Thu, 18 Feb 2021 15:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415e8fd5-4881-497a-1155-08d8d4229471
X-MS-TrafficTypeDiagnostic: BYAPR10MB2901:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29012D4111F45A06332EF552BB859@BYAPR10MB2901.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kJRLW3O/9/dnewv79DwxRBu3N7hF0O7veQD5DEx24QmucbvdB0/N4NcEmAcUP0riOLwPpQQARbdJnW27Ja2Lg18ExA0jFpMkaU1IzfkfIZ3rEtLtzU6QzEJRQZCOLrkvLrhiruq53yJIxIDmUBdV27K8qDtB6uxbv8TqO0GMB75Nzs1hTBKZXPJYLC1/yzGeL9qdoxFMVvX1pLYavJq6Et5a9rcUaMv9eMR7q5BOgrkf73xF1n/hsTM4ZGakoj5MIvhv8YYLxjKxLvbxKcO2u/sGZHIw6T/wlfhWvMrmQg104zGwMkYeSp+4WX9gh/+shAhUY+Vuc31qT0MIeC14dRPm9xtPyCFABL9RbXsOdn6+qu19bRNiJfU+wscRYwPGKaMe0U+ZbW30DaKD/YFBJkYvLis3smW9nW+ejRPuptSA2Na03WuQBYMbjr7SrqbShHn75QEXLFa8uCdDyOMau9fv/0+C5jUVHFKUahaMPmzPuUj5t9a0Y0KwsK+KKv4jPSLhxW7eliuXkRF+nD1Lfa2Vu6sYKGoJmY7J0naheh4zsjuplPEFTA5qs0r9lplUbb17PEssuB/nhvB91GRDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(6666004)(26005)(86362001)(8936002)(6486002)(66556008)(66946007)(83380400001)(16576012)(4326008)(186003)(66476007)(53546011)(478600001)(8676002)(54906003)(16526019)(2906002)(2616005)(36756003)(31686004)(6916009)(5660300002)(31696002)(316002)(956004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWpiOEpMcytOclllYzhaeDdTMThUb3Rzc3IybitPT3R1UmpUTkw1NnUza2Js?=
 =?utf-8?B?S2N1anNhdU9CTkhlajE5TFZSa2Nqdk8yaUQ1V2srNC9JeTdTOXltTWxucmFP?=
 =?utf-8?B?Ump3RU1QQlVJd3VOMEN3czF6anliWkk0WGNaTHV1em83clhGTUtaOXZOOVlL?=
 =?utf-8?B?aXJKb2dWRm15aXR1WnpaUXBMc0Z6WUtnMUlDaGdES2puUGdWTXoxdkRkRDQ5?=
 =?utf-8?B?NmcxNFkvTGFKV3Rhd2NSM0poZjBGbm5sMUxaSXBGT0lvUUFqSTF0Z3ZXanNP?=
 =?utf-8?B?UksraWdNQ0IvWWZXMGZ6QU5yZG1SUDlzQU13ZUVhY0xnOTlvRHVYMkxVY2FP?=
 =?utf-8?B?OW9HbXl2OStvUzczWHdHcy9za1hJU1ppU2lXa01hZlo0NjJFVzJzQTBxQnlY?=
 =?utf-8?B?QlR5dm15SUR4cEtyeFVPVGNhbldaWlZWVFo1aWZkQWgxTDk4Mkc3Z0pQY1Ax?=
 =?utf-8?B?Nk1lNkVtdVJUUGJqcC9oS3F6YzlpSG5pQmcwZVByT2tBZGNQTlFTOGQvOW1Q?=
 =?utf-8?B?MkoraitrY2g4T0JVOWovQ1JHV2lpaE9xSm5Ec0R5YmdKdFNzd1NYeEMreE9H?=
 =?utf-8?B?d2ZxOS9nWXdadG8vZ2NORk5DdlZtdnA2cnA3Y2pQSi9SQUc3Uyt4ZTh3ckZh?=
 =?utf-8?B?bitMVUFJdUNsb1laTVVickNmWU5LTTVFeG5QU3B2NUVmWjVDRERXNjhjaFpU?=
 =?utf-8?B?Z0k0VHJNVWl0dXh3WDErWjZsdFBpdW1BUERBM0Y5dmhiTDNxaEZzMk00UC9S?=
 =?utf-8?B?UWduQnVyS20rRGRQT3dBMnZURW1ndEpyNThQRkIwYldjayt6U1liRzQzVlV5?=
 =?utf-8?B?ZEFMNW42Wms1VW9keE5HSnpEUVJJKzJZTlJkQnRsZVg1NE1OZW1JY285YU55?=
 =?utf-8?B?MDVRZVZaUkRxV0E1NXZOWjZNUm1pY1J1bldMZUZWWll5N0wvTE5qVlBaV1Zh?=
 =?utf-8?B?ZHhobldRMG9uRGljcG5JbStxTzNxbWpOanlSc0NiSW1iQ2RsM21uZUl1MWVn?=
 =?utf-8?B?S0l1WWRUSHNBNlZwclcwWjlLWFRMZHRIckZyZGJ6TlFjRnl6K1Fxb3Y0bWxy?=
 =?utf-8?B?NGtsTmJvZGcvOEt5ZXJMRmlUUGQ1WFBGZHVsc0tsc2RXbGRCM1JzOU02eEFt?=
 =?utf-8?B?VExNNjI3d05vWkxZY1dEMkc4eHRCWSt4Q3A4bmE4V3FiTmFhQkxtNEt5T0JB?=
 =?utf-8?B?eDdlSk11Tk1KWnhWY2FQSmcrNFFhMmNCTWFrTTA4L2xjQmlxMGdGSnRxa21C?=
 =?utf-8?B?NWJvMDF5RDY3WjU2T2F2Z1FtalBRVUkrL1B6YlRHeHpsc0hFVHZ3VWRPSnNx?=
 =?utf-8?B?MTJNdjB4d1JHM3R3eCtNand0VnZNa2FCUnFKOTJhc1Q2TE9rOFlDclYvSVUw?=
 =?utf-8?B?NnFLZmlsWHdzMmE2Z3lWL0w1VmF0OXM0Vzk2a2haa2FqbkxkVC9GdnovTGxL?=
 =?utf-8?B?aHhWbU9pNVhiaVgraGx5OVdXd2ltZFpjalA4c3V5MkdBRllVRWkvS2pMa2VX?=
 =?utf-8?B?bEN6a1lwalI5TzZmUGwvZ0x6QkJvVXB2a1llWmZzaXZUZzg1V2FKbVZhYS9N?=
 =?utf-8?B?NWM4NkVOU0dZekNrUGkzS2UzaWtUUGRqN1EvRHI3UG1XUkxtWlRSMHltMS8y?=
 =?utf-8?B?em9KSU8wZmR3K2FnVXNhQk5vcHExUmxXbnZndUhINE5ob1V0N05kejVkc1dC?=
 =?utf-8?B?TWJnSVBFdkxJMXZncktOUlVrWnZycVpPMjRSQWErTDBhMityNFB4aktoU0VZ?=
 =?utf-8?Q?i+ZmUsvzr2IfEU8FLdDrpQQMkNosoc9ZWr65M3A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415e8fd5-4881-497a-1155-08d8d4229471
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 15:33:46.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGMqFtm/6JtMoIHBafB40UquLcF/y6PqBvhs9FV5URzKUs1Rm8cKDSnac9KkI4rhW8ThEiZf6QmynV8w2bi3zc62C71ZwIJye9HVMvZ2uIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2901
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=927
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180138
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180138
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/18/21 7:24 AM, Christoph Hellwig wrote:
> On Fri, Feb 12, 2021 at 01:08:39PM +0000, Joao Martins wrote:
>> Hey,
>>
>> This series improves page unpinning, with an eye on improving MR
>> deregistration for big swaths of memory (which is bound by the page
>> unpining), particularly:
> 
> Can you also take a look at the (bdev and iomap) direct I/O code to
> make use of this?  It should really help there, with a much wieder use
> than RDMA.
> 
Perhaps by bdev and iomap direct I/O using this, you were thinking to replace
bio_release_pages() which operates on bvecs and hence releasing contiguous pages
in a bvec at once? e.g. something like from this:

        bio_for_each_segment_all(bvec, bio, iter_all) {
                if (mark_dirty && !PageCompound(bvec->bv_page))
                        set_page_dirty_lock(bvec->bv_page);
                put_page(bvec->bv_page);
        }

(...) to this instead:

	bio_for_each_bvec_all(bvec, bio, i)
		unpin_user_page_range_dirty_lock(bvec->bv_page,
			DIV_ROUND_UP(bvec->bv_len, PAGE_SIZE),
			mark_dirty && !PageCompound(bvec->bv_page));
