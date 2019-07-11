Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A36651E1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGKGgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 02:36:13 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:5233 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGKGgM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 02:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562826971; x=1594362971;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NVIGbX/snCKITENIgdT1+y01Kao7Uf3nBpPEAeUMyks=;
  b=l+KhnupJYtICQG1pb+hWrd2Mydkf+Cxs5azm84S4rW8ZJMpqOZmWU4J3
   LT/XpO19QjsxoQH60l0FHX4XJLHeU+wNIAnJO0vE7f+kplCpfqPYjeDAb
   Cd4QTyBiugBbo/ZTWIpvIRv0QVhVfa0FhIz4Z/RaNADheAK44ebjHA4U5
   I=;
X-IronPort-AV: E=Sophos;i="5.62,476,1554768000"; 
   d="scan'208";a="410224801"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 Jul 2019 06:36:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 4165EA21BB;
        Thu, 11 Jul 2019 06:36:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 06:36:08 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.106) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 06:36:05 +0000
Subject: Re: failed armel build of rdma-core 24.0-1
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Drung <benjamin.drung@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>
References: <156275862123.1841.4329369138979653018@wuiet.debian.org>
 <20190710192316.GH4051@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <92fc16f9-d9f2-a05f-b049-137550ab4bfd@amazon.com>
Date:   Thu, 11 Jul 2019 09:35:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710192316.GH4051@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.106]
X-ClientProxiedBy: EX13D23UWA004.ant.amazon.com (10.43.160.72) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/07/2019 22:23, Jason Gunthorpe wrote:
> Benjamin,
> 
> Can you confirm that something like this fixes these build problems?
> 
> diff --git a/debian/rules b/debian/rules
> index 07c9c145ff090c..facb45170eacfc 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -63,6 +63,7 @@ ifneq (,$(filter-out $(COHERENT_DMA_ARCHS),$(DEB_HOST_ARCH)))
>  		test -e debian/$$package.install.backup || cp debian/$$package.install debian/$$package.install.backup; \
>  	done
>  	sed -i '/mlx[45]/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
> +	sed -i '/efa/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
>  endif
>  	DESTDIR=$(CURDIR)/debian/tmp ninja -C build-deb install
>  
> 
> 
> On Wed, Jul 10, 2019 at 11:37:01AM -0000, Debian buildds wrote:
>>  * Source package: rdma-core
>>  * Version: 24.0-1
>>  * Architecture: armel
>>  * State: failed
>>  * Suite: sid
>>  * Builder: antheil.debian.org
>>  * Build log: https://buildd.debian.org/status/fetch.php?pkg=rdma-core&arch=armel&ver=24.0-1&stamp=1562758620&file=log
>>
>> Please note that these notifications do not necessarily mean bug reports
>> in your package but could also be caused by other packages, temporary
>> uninstallabilities and arch-specific breakages.  A look at the build log
>> despite this disclaimer would be appreciated however.

Was this error supposed to be reported by travis as well? I'm pretty sure all
tests passed.
