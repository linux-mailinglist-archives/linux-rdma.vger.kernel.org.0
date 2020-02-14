Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B98415F660
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgBNTHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 14:07:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37168 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgBNTHj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 14:07:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so5326193pfn.4;
        Fri, 14 Feb 2020 11:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NQp08l/9y4q2CuFdBsix/UwClWZG5r6Lh3AJ34P3zu0=;
        b=ShMfSVSt9roFvKixsW44UBB9EEHSujQwYQHkMsR31pmZ1oUpEJTxy21jSH1+2nus+o
         zZiHGhXiw+bDEjexf7eT7QZpD9bMW9ZuwkFpMSx/1MLKzTENXnyKl401Qi6SxaaR1Q52
         BnEWTDdvgF4BSTigy9bliWKWdOVDwSil1w6y1SafCyFkaP1JhDOqKFE8d3W72GXa9bxU
         k62Pi3uWktYg+CAmveGDotRrEQe4k1kG4Zrk7iZFiNLigiGqMo08v44u5ET1rFEcn5W+
         WDSpXshbrevpb9fMfsLRunm8O5VAW0VyZWKSiHaoVRTpBpOUpJb6q018I26SIENRmROm
         E9vw==
X-Gm-Message-State: APjAAAWvpdmjHCF8vxL6enUpVXSKAzbDlrc6MLSt8D5giFhCrc/Tyj9v
        WQiCa+7ZPKw4VG265XArcQxtUyYp
X-Google-Smtp-Source: APXvYqzdzzyBaxbse1m3XluIsctdwKQDuZWQdNP+7dlR0LZeUiA9jlHRMzLddIbjyrAb7kcHhrKr/A==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr4880894pff.135.1581707257693;
        Fri, 14 Feb 2020 11:07:37 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id e4sm7768416pgg.94.2020.02.14.11.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:07:36 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced
 regression related to logout"
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rahul Kundu <rahul.kundu@chelsio.com>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
References: <20200213050900.19094-1-bvanassche@acm.org>
 <fcc55797-40d0-a04f-e2de-6a20a02e6fb6@acm.org>
 <MWHPR1101MB227101D7C2DFEB8ABACD0FCB86150@MWHPR1101MB2271.namprd11.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0763a928-27f4-d6cf-fc54-128ddaf2f47f@acm.org>
Date:   Fri, 14 Feb 2020 11:07:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR1101MB227101D7C2DFEB8ABACD0FCB86150@MWHPR1101MB2271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/20 6:28 AM, Marciniszyn, Mike wrote:
>>
>> [PATCH 0/2] Revert two recent iSCSI / iSER patches
>>
> 
> Bart,
> 
> This will mean we will again see failures in our internal iSer testing.
> 
> What is the status of a final fix?
> 
> If you have something to try, I would be glad to test...

Hi Mike,

Please take another look at this patch series. No new regressions should 
be introduced except if someone runs a bisect that lands in the middle 
of this patch series. Patch 1/2 reintroduces a regression but patches 
1/2 and 2/2 combined should restore iSER to the state of that driver in 
kernel v5.4.

Thanks,

Bart.
