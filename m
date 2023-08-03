Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7476F3C1
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHCUBH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHCUBG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 16:01:06 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 13:01:05 PDT
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DF7420F
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 13:01:05 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id RZpiq6qzdbK1VReTvqtR8F; Thu, 03 Aug 2023 19:59:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ReTuqPMLxhI9KReTuqKfBE; Thu, 03 Aug 2023 19:59:34 +0000
X-Authority-Analysis: v=2.4 cv=ZdwOi+ZA c=1 sm=1 tr=0 ts=64cc0726
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=8y0NZTZfdASZg88ec6MA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TPDYq/13b+187Q0SS/vTNVpKl0QGMUe23edKdHdTGg4=; b=lW4POMbZZz8pdEiKWDgfiN+/9G
        FFTf8XTZRaPbjuVyDp9s3tDARPMd8d80llkfksYznfqBS2D2vEroKNJPX+tqdymbRdh7tTVBTkkjP
        zFj2RLi0w+OQqoANkn5lhj75zaheouGr7u7TMfYX/KFpYRuiEawzTJVGeLcxs4ckYmvU8eGU5Na5i
        Nace+k1AnA78H3qOBesKrDdqR7Nr3Z+5yo1gw2YoJ2FT60oFQ+jnuo+qFyMwa8FS18tC97xYebAOi
        if+uyf10osJrXShxk+Ue12tb3mQec1+EO39g5Lf/+HB1Im0CErSXFR4w5ICfEpTszM1Vi6YRuhZt2
        ULk6K+ew==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60340 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qReTt-001xR4-2u;
        Thu, 03 Aug 2023 14:59:33 -0500
Message-ID: <5979a609-beb9-d622-d8ed-8d01afb56ff4@embeddedor.com>
Date:   Thu, 3 Aug 2023 14:00:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][next] RDMA/irdma: Replace one-element array with
 flexible-array member
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZMpsQrZadBaJGkt4@work>
 <169108630160.1408615.8996122913079845353.b4-ty@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <169108630160.1408615.8996122913079845353.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qReTt-001xR4-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60340
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJTonWwXKRr+EPBMvgzySX4UD6PXVkAonTmSMIz47zLy/Fqco21l1IvAAKr4uq9KC7/TJaixksOQcxBNQWI+MfoLfV6l2BM0G/E3RHMS+EFV3+sgcWa3
 hopeHHKejn3MFZk9tNpmgdpeGDiCIJuGXPzHLUoNszWD61/Ly5FOQFc7zc8d0Pm8MeDb/u6QADnO8u45wI491IT+RDKVDg55/OaRvDXvJKu79HYav+ogiAnC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/3/23 12:11, Leon Romanovsky wrote:
> 
> On Wed, 02 Aug 2023 08:46:26 -0600, Gustavo A. R. Silva wrote:
>> One-element and zero-length arrays are deprecated. So, replace
>> one-element array in struct irdma_qvlist_info with flexible-array
>> member.
>>
>> A patch for this was sent a while ago[1]. However, it seems that, at
>> the time, the changes were partially folded[2][3], and the actual
>> flexible-array transformation was omitted. This patch fixes that.
>>
>> [...]
> 
> Applied, thanks!

Awesome. :)

Thank you!
--
Gustavo

> 
> [1/1] RDMA/irdma: Replace one-element array with flexible-array member
>        https://git.kernel.org/rdma/rdma/c/38313c6d2a02c2
> 
> Best regards,
