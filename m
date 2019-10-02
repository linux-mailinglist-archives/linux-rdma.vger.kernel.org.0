Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC64C8CC7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfJBPVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 2 Oct 2019 11:21:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41323 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfJBPVs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 11:21:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so10510004pfh.8
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 08:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UuQJW0Xaqx4WGkGN/hvSpoKkIyOJoeQiLW5f294wNlo=;
        b=jTxqGSSzKDCm0IoT0HSfecxzhtl8ExHdg5zSqAvYkCijThVF1HF1801A5GW+uH6mnZ
         pJ3jQfNPs+Y9PXkw1tIz1spvIZWh4CnRcko4gZfaNcT4jqGXTr42ddg3T+YnOZJo9Re2
         6ToqS88qkChJIASm93zPSMLEj0EEPtW4cnLctp+RoQ5XOAs4xladA/9v+kUH7KO/OHNb
         H3NB/PHX7zqDhlJ6ncLk5ufFUC01mYvsy5JdIoCEpK7Ahzx0wndT0EDAj40Qej7Inhcd
         Xfdao8nTD4Rf3/4c1hh9tedPvPfiaEhWdx2iyIC3ZlSqI40hAYv9T88iq5ZlOA/AeTR+
         IKvw==
X-Gm-Message-State: APjAAAVQL803X5IQfp0rhbI8FJBEBuXiIqmVq2cL4V9v/miTX/wRCqxj
        boy/GZQPLpoCgEsTrALd2O2/7cb/
X-Google-Smtp-Source: APXvYqzcp3LJmmAbcKJ9jt0PMmiNg2Tb5tCcogxc3UrjP5jH/aNXop3/yOZ7mFLsXMmCqy1KLjDvfw==
X-Received: by 2002:a62:115:: with SMTP id 21mr5452934pfb.110.1570029707917;
        Wed, 02 Oct 2019 08:21:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id u31sm40427365pgn.93.2019.10.02.08.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 08:21:47 -0700 (PDT)
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
 <20191002141451.GA17152@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
Date:   Wed, 2 Oct 2019 08:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002141451.GA17152@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/19 7:14 AM, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
>> Management datagrams (MADs) are not supported by SR-IOV VFs nor by
>> iWARP
> 
> Really? This seems surprising to me..

Hi Jason,

Last time I checked the Mellanox drivers allow MADs to be sent over a
SR-IOV VF but do not allow MADs to be received through such a VF.

I haven't been able to find any reference to management datagrams in the
iWARP RFC. Maybe that means that I overlooked something?

Thanks,

Bart.


