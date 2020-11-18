Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F12B7711
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKRHkH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 02:40:07 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:8858 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKRHkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 02:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605685207; x=1637221207;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=/bFTtAHM7FQ9yKJRVDdaJ1C9iOPo97WJW039+o7FMUI=;
  b=h9V+rQkrxBnSoTWwi7VvsC6AV6/XlHopagPed6ajv8CFcdSl8PNiIwWS
   l2qAnjH8Ju0o8kmXtxUJ30m4VOdLyZPS0zMv4ze7L5xsYRcXcfb7NhPjL
   5KoucKZp+9TGWxWV9XIXWQx7eLHISPEBXGlDzE18t0yiL8guK6I6DCadl
   g=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="67116443"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Nov 2020 07:39:59 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 9E7D9A21E8;
        Wed, 18 Nov 2020 07:39:58 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.102) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 07:39:54 +0000
Subject: Re: [PATCH 4/9] efa: Move the context intialization out of
 efa_query_device_ex()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <529bdbd3-3db4-f317-e403-1c4d670e6a23@amazon.com>
Date:   Wed, 18 Nov 2020 09:39:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.102]
X-ClientProxiedBy: EX13D06UWA002.ant.amazon.com (10.43.160.143) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> When the user calls efa_query_device_ex() it should not cause the context
> values to be mutated, only the attribute shuld be returned.
> 
> Move this code to a dedicated function that is only called during context
> setup.
> 
> Cc: Gal Pressman <galpress@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Didn't get a chance to review yet, but this one breaks EFA.
I'll try to provide more info today/tomorrow.

(BTW: typo in the subject line "intialization", and "shuld" in the commit message)
