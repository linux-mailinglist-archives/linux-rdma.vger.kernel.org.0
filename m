Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC7C8CCC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfJBPXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 2 Oct 2019 11:23:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34318 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfJBPXT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 11:23:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so12033872pgl.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihcgv7Nx7thsOB6ySRthGr5V/W7HAEc7tdcOtGVh2OU=;
        b=HLqdw3IXL2djecbhB6dkL6eYv4uv+G/YnM67qf0tEZrDas5CIR156lZff792PFtsuA
         HEX8WoFXMllgqgL1N3IM/+DeBBm8QIg5BXq6BlNLnPsRwgVKxTztpQAq11iWeZEc64X4
         LDZfcSA3GKNbdNVzaV3JaLHYukhY7UwQh7DAv56W3PqktOS+iRB+moa8loj6871vNOL2
         R16DeuZTsNQsCMFXDCNOsEIF2Yof7ji2eHKbfogLIdHqIT99EErCetLaqOU8T3nW8nDW
         f5lzdzbUthCZWkV0odI9eVv3/ku5HDkHvrFwV6h4hazR/nuCuhY3f/kMt9ElTXuq8ZpU
         e7zg==
X-Gm-Message-State: APjAAAWtt0YPlQEzVQzjuobGi5UOHo+dskATRVXOLx5XM9x51fRUQVfp
        ms+RuMz610nxYHKBscMSbPg=
X-Google-Smtp-Source: APXvYqwAQUdCU/nfDOuHkttEZ87atnNxEfddgkPxZCg41KTiyrSZr8LNRThJ6MVaxN3Qesmw3ONN1Q==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr4720648pja.26.1570029799187;
        Wed, 02 Oct 2019 08:23:19 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id r2sm22508176pfq.60.2019.10.02.08.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 08:23:18 -0700 (PDT)
Subject: Re: [PATCH 10/15] RDMA/srpt: Fix handling of iWARP logins
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-11-bvanassche@acm.org>
 <20191002141600.GB17152@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <62fb8814-1668-b7a6-3d1c-f86650478b05@acm.org>
Date:   Wed, 2 Oct 2019 08:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002141600.GB17152@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/19 7:16 AM, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2019 at 04:17:02PM -0700, Bart Van Assche wrote:
>> The path_rec pointer is NULL set for IB and RoCE logins but not for iWARP
>> logins. Hence check the path_rec pointer before dereferencing it.
> 
> Did you mean it is null set for iWARP logins? I would expect iwarp to
> not have a pkey..

Yes, I meant that the path_rec pointer is NULL for iWARP logins. The
word "NULL" should be removed from the commit message.

Thanks,

Bart.

