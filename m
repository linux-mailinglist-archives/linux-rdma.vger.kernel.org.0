Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9C1D99B3
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgESO3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 10:29:19 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38292 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgESO3T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 10:29:19 -0400
Received: by mail-pj1-f67.google.com with SMTP id t40so1497254pjb.3;
        Tue, 19 May 2020 07:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6t0EC/dgujfakdDpEmbdYC57HT1wMjhWS1oZoZRUl8g=;
        b=NuUSKbwGilr9J1fWURnxHwmLfT42tzRyYJVWwtGhqMiBKH/pVRdL3FeizGubofl8dK
         71ArvvSb83cnDt/DhVZ9Y5UJNGldsf+rfexUqxb8aMJkj5ZnxtyDb4Rm6C7o69/7bNaG
         EkqMvbX0oLZPAFBddfZO1s9KCORV55FSqRcSRiirC1Gm08FBQ+hj2xQsMCIBbMp9tI8M
         DPeKc/Oa9vv1xqJUcx6Vdzm57f6Yq6ZipsL8cN2b+KHuCSDG5HydmsCRmXE3znAHw2DB
         X5sdih5nSrEHWjL5qUJxG9FsRSm9LkCpe/zdR21YgNSQkIrSrb+TwdyacxZRPHF2rlRF
         +QKg==
X-Gm-Message-State: AOAM533qe02w1UYvH6JwOjzLaHP/AvovDb3XI/zsV6WThLGJOzx7bmQK
        kesOs5eSFw0MFt4zAzsae8E=
X-Google-Smtp-Source: ABdhPJyA4dqPecvRxlsDtRwKMEmAnwGpLddE0PXNqBxkJtP3aUUP+WQl0w8kMeFTz991nhx6FXM9ig==
X-Received: by 2002:a17:90a:e990:: with SMTP id v16mr5039963pjy.62.1589898557625;
        Tue, 19 May 2020 07:29:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a402:5dc4:a04b:e81f? ([2601:647:4000:d7:a402:5dc4:a04b:e81f])
        by smtp.gmail.com with ESMTPSA id w190sm11063875pfw.35.2020.05.19.07.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 07:29:16 -0700 (PDT)
Subject: Re: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting
 smatch warning
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     leon@kernel.org, jinpu.wang@cloud.ionos.com,
        kbuild test robot <lkp@intel.com>
References: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
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
Message-ID: <76b6b987-4f63-2487-7fbe-a1d9c2f06b76@acm.org>
Date:   Tue, 19 May 2020 07:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-19 04:29, Danil Kipnis wrote:
> Kbuild test robot reports a smatch warning:
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1196 rtrs_clt_failover_req() warn: inconsistent indenting
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2890 rtrs_clt_request() warn: inconsistent indenting
> 
> To get rid of the warning, move the while_each_path() macro to a newline.
> Rename the macro to end_each_path() to avoid the "while should follow close
> brace '}'" checkpatch error.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  v1->v2 Add fixes line
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 468fdd0d8713..0fa3a229d90e 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -734,7 +734,7 @@ struct path_it {
>  			  (it)->i < (it)->clt->paths_num;		\
>  	     (it)->i++)
>  
> -#define while_each_path(it)						\
> +#define end_each_path(it)						\
>  	path_it_deinit(it);						\
>  	rcu_read_unlock();						\
>  	}
> @@ -1193,7 +1193,8 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
>  		/* Success path */
>  		rtrs_clt_inc_failover_cnt(alive_sess->stats);
>  		break;
> -	} while_each_path(&it);
> +	}
> +	end_each_path(&it);
>  
>  	return err;
>  }
> @@ -2887,7 +2888,8 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
>  		}
>  		/* Success path */
>  		break;
> -	} while_each_path(&it);
> +	}
> +	end_each_path(&it);
>  
>  	return err;
>  }

I don't like the do_each_path() and end_each_path() macros because these do not
follow the pattern that is used elsewhere in the kernel to use a single macro
to iterate over a custom container. Has it been considered to combine these two
macros into a single macro, e.g. something like the following (untested) patch?


Subject: [PATCH] Combine while_each_path() and do_each_path() into
 for_each_path()

---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 468fdd0d8713..8dfa56dc32bc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -727,18 +727,13 @@ struct path_it {
 	struct rtrs_clt_sess *(*next_path)(struct path_it *it);
 };

-#define do_each_path(path, clt, it) {					\
-	path_it_init(it, clt);						\
-	rcu_read_lock();						\
-	for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&		\
-			  (it)->i < (it)->clt->paths_num;		\
+#define for_each_path(path, clt, it)					\
+	for (path_it_init((it), (clt)), rcu_read_lock(), (it)->i = 0;	\
+	     (((path) = ((it)->next_path)(it)) &&			\
+	      (it)->i < (it)->clt->paths_num) ||			\
+		     (path_it_deinit(it), rcu_read_unlock(), 0);	\
 	     (it)->i++)

-#define while_each_path(it)						\
-	path_it_deinit(it);						\
-	rcu_read_unlock();						\
-	}
-
 /**
  * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
  * @head:	the head for the list.
@@ -1177,7 +1172,7 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
 	int err = -ECONNABORTED;
 	struct path_it it;

-	do_each_path(alive_sess, clt, &it) {
+	for_each_path(alive_sess, clt, &it) {
 		if (unlikely(READ_ONCE(alive_sess->state) !=
 			     RTRS_CLT_CONNECTED))
 			continue;
@@ -1193,7 +1188,7 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
 		/* Success path */
 		rtrs_clt_inc_failover_cnt(alive_sess->stats);
 		break;
-	} while_each_path(&it);
+	}

 	return err;
 }
@@ -2862,7 +2857,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 		dma_dir = DMA_TO_DEVICE;
 	}

-	do_each_path(sess, clt, &it) {
+	for_each_path(sess, clt, &it) {
 		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
 			continue;

@@ -2887,7 +2882,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 		}
 		/* Success path */
 		break;
-	} while_each_path(&it);
+	}

 	return err;
 }
