Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1FFBE7C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 04:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNDxM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 22:53:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfKNDxM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 22:53:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so3185343pff.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2019 19:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0VW5kQLEh7XRTeIVTJWEzeOnDwr0eHeYI1C3cMVGFXg=;
        b=EbcGK2J2y/pjjMyddoQ5dmoQLdecSzAsEKc7jWVmRuNHE3hSTcnrc+ymWehx/+lrga
         hDeqDHaVpSwOB0nYF7ByjoTRn9sWW+gTHJxoHI4nNSaKhDrnqMk85KcSweHZ2KgohUrs
         MaQaPUTt7ySF7DFIyJcKa9Wdu11AfD8sE6ThqQUGArV2zQZ2Ty+IZpdyUPpOtNrsGdbI
         SZCiDreEec9qot2acBbW99GeJKhFQPc2APNiquNzu86Tro5cxC5iiiiNkzSUMJMbHslI
         jkq0w7WTHgH4roFWjXsbMQKO5GswD2etP6OLcVojDS/ktCtwRhFohA5GGwDav2G036Y3
         wfkA==
X-Gm-Message-State: APjAAAVGSVC2TTItHUdfA/egCVj1JY9n833ZLL/jg6yIbXOpsyiT8Bjv
        1MAWuGWxy8m4RvCbs7L4vKk=
X-Google-Smtp-Source: APXvYqwjhyadCvwRjpl+/7R9SujaR3e2zV+rji3lXLZgX1nFJZDVLGZXhaERYwbNDkMfb2QpuPg28w==
X-Received: by 2002:a17:90b:3d3:: with SMTP id go19mr9620537pjb.78.1573703591192;
        Wed, 13 Nov 2019 19:53:11 -0800 (PST)
Received: from ?IPv6:2601:647:4000:a8:cb7:5e35:ff76:162c? ([2601:647:4000:a8:cb7:5e35:ff76:162c])
        by smtp.gmail.com with ESMTPSA id y3sm4397999pgl.78.2019.11.13.19.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 19:53:10 -0800 (PST)
Subject: Re: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Honggang LI <honli@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
References: <20191105214632.183302-1-bvanassche@acm.org>
 <20191106031311.GA19586@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <5093f8ca-056f-e8c7-2912-86fdd9d70fe9@acm.org>
Date:   Wed, 13 Nov 2019 19:53:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191106031311.GA19586@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-11-05 19:13, Honggang LI wrote:
> On Tue, Nov 05, 2019 at 01:46:32PM -0800, Bart Van Assche wrote:
>> The code added by this patch is similar to the code that already exists
>> in ibmvscsis_determine_resid(). This patch has been tested by running
>> the following command:
> [ ... ]
> Acked-by: Honggang Li <honli@redhat.com>

Hi Jason,

Please let me know if you want me to repost this patch.

Thanks,

Bart.


