Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3BBB795
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfIWPKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 11:10:53 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39901 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfIWPKx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 11:10:53 -0400
Received: by mail-pl1-f176.google.com with SMTP id s17so5159217plp.6
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 08:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAGStYn7t/Hn/6DWJNd+JuJS2rpvr4NZYWjbA+7tFOg=;
        b=tJX1ADqURp3fHpCFp6Is9bp8TmJeN4sMVhsvBpF9RiuRprWH4AU4+ZUh0w4ZDJZkIL
         Ppm34v6lor8WVR+EvXHBh/uVHqjroOC36s853twC1Fm5SioYGQDBojKEMPwMgM+cUjIY
         cZ02ADmp2Ugu+lXy6MbtIK1eykaAZyZG6DMTLkM2DdN8m2xdSQnyJI4zRbACoN/ds2JO
         8m4m6rCbh/buh1LE3w04PxGoC7Yx9l1Jp5Zxr3WWHei5qKt05k8p/TRbnLrMyAY3Hr4Z
         Bt2CrELrR6AAQOPEcXQ/lblj61rVU7Zz3+wzp5yOCo1VPZF0uVLZOVMwOr0p12/h6uoU
         P6yw==
X-Gm-Message-State: APjAAAU11Z/Yza694koY8fNKcocVrYcMaxDI6FOPXHb3vGYoEuGZbf09
        pt4s6OvbO4i6SDmGHeJCzyhP58Li
X-Google-Smtp-Source: APXvYqyIRPzQ3qZsFLwDSBzEG+RJHTa5V7zV+Il7DouQayIjKzCtOhT/9NIuPNVZFhHVoqtFBg5HXA==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr254660plx.174.1569251451892;
        Mon, 23 Sep 2019 08:10:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e14sm5532512pjt.8.2019.09.23.08.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:10:50 -0700 (PDT)
Subject: Re: [patch v3 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
To:     Honggang LI <honli@redhat.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20190919035032.31373-1-honli@redhat.com>
 <20190919035032.31373-2-honli@redhat.com>
 <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
 <20190923033339.GB8298@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0f2331d1-6a4a-6c30-6e53-9662c2a59708@acm.org>
Date:   Mon, 23 Sep 2019 08:10:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923033339.GB8298@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/19 8:33 PM, Honggang LI wrote:
> On Fri, Sep 20, 2019 at 09:18:49AM -0700, Bart Van Assche wrote:
>> On 9/18/19 8:50 PM, Honggang LI wrote:
>>> The maximum initiator to target iu length can be get from the subnet
>>                                                     ^^^
>>                                           retrieved? obtained?
> 
> OK, will replace it with 'retrieved'.
> 
>>> manager, such as opensm and opafm. We should calculate the
>>    ^^^^^^^
>>
>> Are you sure that information comes from the subnet manager?
>> Isn't the LID passed to get_ioc_prof() in the srp_daemon the LID of the SRP
>> target?
> 
> Yes, you are right. But srp_daemon/get_ioc_prof() send MAD packet
> to subnet manager to obtain the maximum initiator to target iu length.
  I do not agree that the maximum initiator to target IU length comes 
from the subnet manager. This is how I think the srp_daemon works:
1. The srp_daemon process sends a query to the subnet manager and asks
    the subnet manager to report all IB ports that support device
    management.
2. The subnet manager sends back information about all ports that
    support device management (struct srp_sa_port_info_rec).
3. The srp_daemon sends a query to the SRP target(s) to retrieve the
    IOUnitInfo (struct srp_dm_iou_info) and IOControllerProfile
    (struct srp_dm_ioc_prof). The maximum initiator to target IU length
    is present in that data structure (srp_dm_ioc_prof.send_size).

Bart.
